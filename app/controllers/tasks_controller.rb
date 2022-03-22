class TasksController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
 before_action :set_task, only: %i[ show edit update destroy ]

 # GET /tasks or /tasks.json
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
   else
     @tasks = Task.where(user_id: current_user.id).order(created_at: :desc).page params[:page]
   end
 end



 # GET /tasks/1 or /tasks/1.json
 def show
 end

 # GET /tasks/new
 def new
   @task = Task.new
 end

 # GET /tasks/1/edit
 def edit
 end

 # POST /tasks or /tasks.json
 def create
   @task = Task.new(task_params)
   @task.user_id = current_user.id
   respond_to do |format|
     if @task.save
       format.html { redirect_to task_url(@task), notice: "Task was successfully created." }
       format.json { render :show, status: :created, location: @task }
     else
       format.html { render :new, status: :unprocessable_entity }
       format.json { render json: @task.errors, status: :unprocessable_entity }
     end
   end
 end

 # PATCH/PUT /tasks/1 or /tasks/1.json
 def update
   @task.user_id = current_user.id
   respond_to do |format|
     if @task.update(task_params)
       format.html { redirect_to task_url(@task), notice: "Task was successfully updated." }
       format.json { render :show, status: :ok, location: @task }
     else
       format.html { render :edit, status: :unprocessable_entity }
       format.json { render json: @task.errors, status: :unprocessable_entity }
     end
   end
 end

 # DELETE /tasks/1 or /tasks/1.json
 def destroy
   @task.destroy

   respond_to do |format|
     format.html { redirect_to tasks_url, notice: "Task was successfully destroyed." }
     format.json { head :no_content }
   end
 end

 private
   # Use callbacks to share common setup or constraints between actions.
   def set_task
     @task = Task.find(params[:id])
   end

   # Only allow a list of trusted parameters through.
   def task_params
     params.require(:task).permit(:title, :detail, :deadline, :priority, :status)
   end
end
