class TasksController < ApplicationController
skip_before_action :login_required, only: [:new, :create]
before_action :set_task, only: %i[ show edit update destroy ]

 def index
   if params[:sort].present?
      @tasks = Task.where(user_id: current_user.id).order(params[:sort]).page params[:page]
        elsif params[:sort_priority]
      @tasks = Task.where(user_id: current_user.id).order(priority: :asc).page params[:page]
    elsif params[:title].present?
      if params[:status].present?
        @tasks = Task.where(user_id: current_user.id).title_search(params[:title]).status_search(params[:status]).page params[:page]
      else
        @tasks = Task.where(user_id: current_user.id).title_search(params[:title]).page params[:page]
      end
    elsif params[:status].present?
      @tasks = Task.where(user_id: current_user.id).status_search(params[:status]).page params[:page]
    elsif params[:label_id].present?
      task_id = TaskLabel.where(label_id: params[:label_id]).pluck(:task_id)
      @tasks = Task.where(id: task_id[0]).page params[:page]
    else
      @tasks = Task.where(user_id: current_user.id).order(created_at: :desc).page params[:page]
    end
 end



 def show
 end

 def new
   @task = Task.new
 end

 def edit
 end

 def create
   @task = Task.new(task_params)
   @task.user_id = current_user.id
     if @task.save
       redirect_to tasks_path, notice: "Task was successfully created."
     else
       render :new
     end
  end

 def update
   @task.user_id = current_user.id
     if @task.update(task_params)
       redirect_to tasks_path, notice: "Task was successfully updated."
     else
       render :edit
     end
  end

 def destroy
   @task.destroy
   redirect_to tasks_path, notice: "Task was successfully destroyed."
 end

 private

   def set_task
     @task = Task.find(params[:id])
   end

   def task_params
     params.require(:task).permit(:title, :detail, :deadline, :priority, :status, label_ids: [])
   end
end
