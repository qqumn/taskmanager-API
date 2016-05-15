class ProjectsController < ApplicationController
  def index
    projects = Project.all
    render json: projects, status: :ok
  end

  private

  def project
    @project ||= project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:name, :description)
  end
end
