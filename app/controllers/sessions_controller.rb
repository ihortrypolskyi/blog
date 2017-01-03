class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by_email(params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      redirect_to '/posts'
      flash[:notice] = t('.notice')
    else
      flash[:alert] = t('.alert')
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = t('.notice')
    redirect_to '/login'
    # could be replaced by: reset_session
  end
end
