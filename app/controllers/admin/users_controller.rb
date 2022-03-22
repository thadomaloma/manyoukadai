class Admin::UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
	before_action :check_if_admin

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			redirect_to admin_users_path
		else
			render :new
		end
	end

	def index
		if params[:admin].present?
			@user = User.find(params[:id])
			@user.update(is_admin: params[:admin])
		end
		@user = User.all.includes(:tasks)
	end

	def show
		@user = User.find(params[:id])
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if params[:is_admin]
			@user.update_attribute :is_admin, params[:is_admin]
			respond_to do |format|
				format.html { redirect_to admin_users_path, notice: "user was successfully updated" }
			end
		else
			if @user.update(user_params)
				redirect_to admin_users_path
			else
				render :edit
			end
		end
	end

		def destroy
			@user = User.find(params[:id])
			@user.destroy
			redirect_to admin_users_path, notice: "user has successfully destroyed"
		end

		private

		def check_if_admin
			redirect_to root_path, notice: "Only admin can access the administration screen" unless current_user.is_admin?
		end

		def user_params
			params.require(:user).permit(:name, :email, :password, :password_confirmation, :is_admin)
		end

		def set_user
			@user = User.find(params[:id])
		end
end
