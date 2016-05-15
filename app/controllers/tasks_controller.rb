class TasksController < ApplicationController
  def index
    render json: current_user.tasks, status: :ok
  end

  def show
    render json: task, status: :ok
  end

  def create
    task = project.tasks.new(task_params)
    if task.save
      render json: task, status: :created
    else
      render json: task.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    if task.update(task_params)
      render json: task, status: :ok
    else
      render json: task.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    task.delete
    head :ok
  end

  def assign_me
    task.update(executor_id: current_user.id, status: 1)
    render json: task, status: :ok
  end

  def marked_done
    task = current_user.executive_tasks.find(params[:id])
    if task.update(status: 2)
      render json: task, status: :ok
    else
      render json: task.errors.full_messages, status: :not_found
    end
  end

  private

  def task
    @task ||= project.tasks.find(params[:id])
  end

  def project
    @project ||= Project.find(params[:project_id])
  end

  def task_params
    params.require(:task).permit(:name, :description, :status, :executor_id).merge(user: current_user)
  end
end
