class TasksController < ApplicationController
  before_action :authenticate_user!

  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
    @task.assignments.new
  end

  def create
    @task = Task.new(task_params)
    # @assignment = current_user.assignment.new
    @task.assignments.first.user_id = current_user.id

    if @task.save
      redirect_to tasks_path
    else
      render 'new'
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path
  end

  private
    def task_params
      params.require(:task).permit(:description, :completed, :completed_date, assignments_attributes: [:ownership])
    end

    def assignment_params
      params.require(:task).permit(:ownership, :user_id)
    end
end
