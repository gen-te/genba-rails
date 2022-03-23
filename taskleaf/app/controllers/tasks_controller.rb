class TasksController < ApplicationController
  def index
    @task = current_user.tasks
  end

  def show
    @task = current_user.tasks.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def edit
    @task = current_user.tasks.find(params[:id])
  end

  def update
    task = current_user.tasks.find(params[:id])
    task.update!(task_params)
    redirect_to tasks_url, notice: "task #{task.name} updated"
  end

  def create
    @task = current_user.tasks.new(task_params) 

    if @task.save
      redirect_to tasks_url, notice: "task #{@task.name} created"
    else
      render :new
    end
  end
  
  def destroy
    task = current_user.tasks.find(params[:id])
    task.destroy
    redirect_to tasks_url, notice: "task  #{task.name} deleted"
  end
  private

  def task_params
    params.require(:task).permit(:name, :description)
  end
end
