class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to '/posts'
      flash[:notice] = t('.notice')
    elsif !@user.first_name.length.between?(3, 30) || !@user.last_name.length.between?(3, 30) || !@user.password.length.between?(3, 30)
      flash[:alert] = t('.alert')
      redirect_to '/signup'
    else
      flash[:error] = t('.error')
      redirect_to '/signup'
    end
  end

  private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password)
    end
end
