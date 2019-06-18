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
    @task.update_attributes(task_params)
  end

  def update_multiple
    @selected = params[:tasks_ids]

    Task.all.update_all(completed: false) # completed_date will be overwrite when the task becomes completed
    Task.where(:id => @selected, :completed => false).update_all(completed: true, completed_date: Time.now)

    redirect_to '/'
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
