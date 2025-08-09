module Api
  module V1
    class ProjectsController < ApplicationController
      # include AuthorizeRequest

      before_action :load_project, only: [ :show, :edit, :destroy ]

      def create
        project = current_user.projects.create!(project_params)

        if current_user.member?
          project.member_projects.create!(user: current_user, role: :manager)
        end

        res({}, status: :created)
      end

      def index
        # projects = current_user.admin? ? Project.all : current_user.projects
        projects = Project.all

        res(projects, as: :list)
      end

      def show
        res(@project)
      end

      def edit
        raise ApiErrors::UnauthorizedError  if current_user.only_read?(@project.id)

        res(@project)
      end

      def destroy
        raise ApiErrors::UnauthorizedError unless current_user.member? && !current_user.has_owner?(@project)

        @project.destroy
        res({}, message: "Delete successful!")
      end

      def update
        return raise ApiErrors::UnauthorizedError  if current_user.only_read?(@project.id)

        @project.update!(project_params)
        res({})
      end

      private

      def load_project
        @project ||= current_user.admin? ? Project.find(params[:id]) : current_user.projects.find(params[:id])
      end

      def project_params
        params.require(:project).permit(:name, :description, :visibility)
      end
    end
  end
end
