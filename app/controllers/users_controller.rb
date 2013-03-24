class UsersController < ApplicationController
	before_filter :authenticate, :only => [:edit, :update, :index, :destroy]
	before_filter :correct_user, :only => [:edit, :update]
	before_filter :administrator,   :only => :destroy

	def show
		@user = User.find(params[:id])
		@title = @user.name
	end

	def new
		@user = User.new(params[:user])
		@title = "Sign up"
	end

	def create
		@user = User.new(params[:user])
		if @user.save
			UserNotify.welcome(@user).deliver
			sign_in @user
			flash[:success] = "Welcome to the Ruby testing!"
			redirect_to @user
		else
			@title = "Sign up"
			render 'new'
		end
	end

	def index
		@title = "Users list"		
	end

	def edit
		@user = User.find(params[:id])
		@title = "Settings"
	end

	def update
		@user = User.find(params[:id])
		if @user.update_attributes(params[:user])
			flash[:success] = "Profile updated."
			redirect_to @user
		else
			@title = "Edit user"
			render 'edit'
		end
	end

	def destroy
		User.find(params[:id]).destroy
		flash[:success] = "User destroyed."
		redirect_to users_path
	end

	private

	def authenticate
		deny_access unless signed_in?		
	end

	def administrator
		redirect_to(root_path) unless current_user.role == "admin"
	end

	def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user == @user
    end
end
