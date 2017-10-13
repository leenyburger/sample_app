class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by(email: params[:session][:email].downcase)
  	if user && user.authenticate(params[:session][:password])
  		#log in and redirect to show page
  		log_in user #From the sessions_helper, which was added to application_controller so is accessible everywhere.
  		redirect_to user
  	else
  		flash.now[:danger] = 'Invalid email/password combination'
  		render 'new' #Rerendering a template with render doesn't count as a request
  	end
  end

  def destroy
  end

end
