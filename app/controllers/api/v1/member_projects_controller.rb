module Api
  module V1
    class MemberProjectsController < ApplicationController
      include AuthorizeRequest
      before_action :load_project
      before_action :load_member_project, only: :update

      def update
        return ForbiddenError unless current_user.admin? || current_user.manager_in_project?(@project)

        @member_project.update!(role: params[:role])
        res({}, message: "Member role updated successfully")
      end

      private

      def load_project
        @project = current_user.admin? ? Project.find(params[:project_id]) : current_user.projects.find(params[:project_id])
      end

      def load_member_project
        @member_project = @project.member_projects.find_by(user_id: params[:id])

        raise ActiveRecord::RecordNotFound, "Member not found" unless @member_project
      end
    end
  end
end
