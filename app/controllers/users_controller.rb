class UsersController < ApplicationController
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
end
