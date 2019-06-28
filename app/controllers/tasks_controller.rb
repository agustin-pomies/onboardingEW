class TasksController < ApplicationController
  before_action :authenticate_user!

  def restart
    @completed = Task.where('completed_date < ?', Date.current.at_beginning_of_month)
    @completed.update_all(completed: false, completed_date: nil)
  end

  def index
    restart
    @tasks = current_user.tasks.order(:updated_at)
  end

  def show
    @task = Task.find(params[:id])
    @collaborators = @task.users
    @potential_collab = User.where.not(id: @collaborators.pluck(:id))
  end

  def new
    @task = Task.new
    @task.assignments.new
  end

  def edit
    @users = User.all
    @task = Task.find(params[:id])
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
    if @task.update(task_params)
      redirect_to task_path(@task), notice: 'Task completed!'
    else
      redirect_to task_path(@task), notice: 'Error'
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path
  end

  private
    def task_params
      params.require(:task).permit(:description, :completed, :completed_date,
        assignments_attributes: [:ownership, :user_id])
    end
end

def is_owner(task, user)
  return task.assignments.exists?(user_id: user.id, ownership: true)
end
