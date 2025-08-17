module Api
  module V1
    class ProjectsController < ApplicationController
      include AuthorizeRequest

      before_action :load_project, only: [ :show, :edit, :destroy, :joined_members, :update ]

      def create
        project = current_user.projects.create!(project_params)

        if current_user.member?
          project.member_projects.create!(user: current_user, role: :manager)
        end

        res({}, status: :created)
      end

      def index
        projects = current_user.admin? ? Project.all : current_user.joined_projects

        res(projects.order(:id), as: :list)
      end

      def show
        res(@project)
      end

      def edit
        raise ApiErrors::ForbiddenError  if current_user.only_read?(@project.id)

        res(@project)
      end

      def destroy
        raise ApiErrors::ForbiddenError if current_user.member? && !current_user.has_owner?(@project)

        @project.destroy
        res({}, message: "Delete successful!")
      end

      def update
        return raise ApiErrors::ForbiddenError  if current_user.only_read?(@project.id)

        @project.update!(project_params)
        res({})
      end

      def joined_members
        res(@project.member_projects, as: :list)
      end

      private

      def load_project
        @project ||= current_user.admin? ? Project.find(params[:id]) : current_user.joined_projects.find(params[:id])
      end

      def project_params
        params.require(:project).permit(:name, :description, :visibility)
      end
    end
  end
end
