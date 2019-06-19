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

  def edit
    @task = Task.find(params[:id])
    @users = User.all
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to tasks_path
    else
      render 'new'
    end
  end

  def update
    @task = Task.find(params[:id])

    respond_to do |format|
      if @task.update(task_params)
        redirect_to root_path, notice: 'Task completed!'
      else
        redirect_to root_path, notice: 'Error'
      end
    end

  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path
  end

  private
    def task_params
      params.require(:task).permit(:description, :completed, :completed_date, assignments_attributes: [:ownership, :user_id])
    end
end
