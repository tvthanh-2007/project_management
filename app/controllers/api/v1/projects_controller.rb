module Api
  module V1
    class ProjectsController < ApplicationController
      include AuthorizeRequest

      before_action :load_project, only: [ :show, :edit, :destroy ]

      def create
        project = current_user.projects.new(project_params)

        if project.save
          if current_user.member?
            project.member_projects.create!(user: current_user, role: :manager)
          end

          res({}, status: :created)
        else
          errors = project.errors.map do |attr, msg|
            { attribute: attr.to_s, message: msg }
          end

          render_error(errors)
        end
      end

      def index
        projects = current_user.admin? ? Project.all : current_user.projects

        res(projects, as: :list)
      end

      def show
        res(@project)
      end

      def edit
        return render_error(message: "Unauthorized!", status: :unauthorized)  if current_user.only_read?(@project.id)

        res(@project)
      end

      def destroy
        if current_user.admin? || current_user.has_owner?(@project)
          @project.destroy
          return
        end

        render_error(message: "Unauthorized!", status: :unauthorized)
      end

      def update
        return render_error(message: "Unauthorized!", status: :unauthorized)  if current_user.only_read?(@project.id)

        @project.update(project_params)
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
