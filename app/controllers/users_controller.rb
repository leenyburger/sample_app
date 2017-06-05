class UsersController < ApplicationController
  def new
  	@user = User.new #Signup page is routed to "new" action.  Data will come from form 
  end

  def show
  	@user= User.find(params[:id]) #Show current user

  end


end
