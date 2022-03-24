class LabelsController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
	before_action :set_label, only: [:show, :edit, :update, :destroy]

	def new
		@label = Label.new
	end

	def create
		@label = Label.new(label_params)
		@label.user_id = current_user.id
		if @label.save
			flash[:notice] = "You created a label"
			redirect_to labels_path
		else
			render :new
		end
	end

	def index
		@labels = current_user.labels.all
	end

	def show
	end

	def edit
	end

	def update
		@label.user_id = current_user.id
		if @label.update(label_params)
			flash[:notice] = "You edited a label"
			redirect_to labels_path
		else
			render :edit
		end
	end

	def destroy
		if @label.destroy
			flash[:notice] = "You deleted a label"
			redirect_to labels_path
		end
	end

	private
	def label_params
		params.require(:label).permit(:name)
	end

	def set_label
		@label = Label.find(params[:id])
	end
end
