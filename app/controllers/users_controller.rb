class UsersController < ApplicationController
  def new
  	@user = User.new #Signup page is routed to "new" action.  Data will come from form
  end

  def show
  	@user= User.find(params[:id]) #Show current user
  end

  def create
  	@user=User.new(user_params)
	  if @user.save
      log_in @user
      flash[:success] = "Welcome to the Sample App"
      redirect_to @user
    else
      render 'new'
	  end
	end



private

  	def user_params
  		params.require(:user).permit(:name, :email, :password, :password_confirmation)
  	end
end
