class Admin::UsersController < ApplicationController
  before_action :check_if_admin
  before_action :set_user, only: [:show, :edit, :destroy, :update]

  def index
    @users = User.includes(:tasks)
  end

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		if @user.save
			redirect_to admin_users_path, notice: "Registered user #{@user.name}"
		else
			render :new
		end
	end

	def edit
	end

  def update
		if @user.update(user_params)
			redirect_to admin_users_path, notice: "User was successfully updated"
		else
			render :edit
		end
  end

  def show
  end

	def destroy
    @user = User.find(params[:id])
		@user.destroy
		redirect_to admin_users_path, notice: "User has successfully destroyed"
  end 

  private
		def check_if_admin
			redirect_to root_path, notice: "Only admin can access the administration screen" unless current_user.is_admin?
		end

		def set_user
			@user = User.includes(:tasks).find(params[:id])
		end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :is_admin)
    end
end
