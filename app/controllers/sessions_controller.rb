class SessionsController < ApplicationController
  #def index
  #end

  def new
  end

  def create
    @user = User.find_by_email(params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      redirect_to '/posts'
    else
      flash[:alert] = "Please, make sure you fill in fields properly"
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You have successfully logged out"
    redirect_to '/login'
    # could be replaced by: reset_session
  end
end
