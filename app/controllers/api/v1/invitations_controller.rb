module Api
  module V1
    class InvitationsController < ApplicationController
      include AuthorizeRequest

      before_action :load_project
      before_action :load_invitation, only: :accept

      def create
        raise ApiErrors::ForbiddenError unless current_user.admin? || current_user.manager_in_project?(@project)

        @project.invitations.pending.where(email: invitation_params[:email]).delete_all

        invitation = @project.invitations.new(invitation_params.merge(status: :pending))
        invitation.token = SecureRandom.hex(20)
        invitation.expires_at = 7.days.from_now
        invitation.save!

        InvitationMailer.invite_email(invitation).deliver_now
        res({}, message: "Invitation sent",  status: :created)
      end

      def accept
        raise ApiErrors::InvitationError, "Invitation invalid!" if @invitation.nil?
        raise ApiErrors::InvitationError, "Invitation not belong to you!" if @invitation.email != current_user.email
        raise ApiErrors::InvitationError, "Invitation expired!" if @invitation.invalid?

        return res({}, message: "You had joined project") if @invitation.accepted?

        MemberProject.create!(user: current_user, project: @invitation.project, role: @invitation.role)
        @invitation.accept!

        res({}, message: "Invitation accepted!")
      end

      private

      def load_project
        @project ||= current_user.admin? ? Project.find(params[:project_id]) : current_user.projects.find(params[:project_id])
      end

      def load_invitation
        @invitation = @project.invitations.pending.find_by(token: params[:token], email: params[:email])
      end

      def invitation_params
        params.require(:invitation).permit(:email, :role)
      end

      def manager_in_project?
        current_user.member_prejects.find_by(project_id: @project.id)&.manager?
      end
    end
  end
end
