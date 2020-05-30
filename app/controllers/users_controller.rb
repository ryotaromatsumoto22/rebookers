class UsersController < ApplicationController
	  before_action :authenticate_user!

	def show
		@book = Book.new
		@user = User.find(params[:id])
		@books = @user.books
	end

	def index
		@book = Book.new
		@user = current_user || User.find_by(id:session[:user_id])
		@users = User.all
	end

	def edit
		@user = User.find(params[:id])
		if @user == current_user
			render action: :edit
		else
			redirect_to user_path(current_user.id)
		end
	end

	def update
		@user = User.find(params[:id])
  		if @user.update(user_params)
  	   		redirect_to user_path(@user.id), notice: "You have updated user successfully."
    	else
      		render :edit
    	end
	end

	private	
	def user_params
		params.require(:user).permit(:name, :introduction, :profile_image)
	end


end

