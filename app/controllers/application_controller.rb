class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale

  helper_method :current_user

  def locale_en
    cookies[:locale] = 'en'
    I18n.locale = params[:locale]
    redirect_to '/posts'
  end

  def locale_ru
    cookies[:locale] = 'ru'
    I18n.locale = params[:locale]
    redirect_to '/posts'
  end

  def current_user
  @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_user
  redirect_to '/login' unless current_user
  end

  private
  def set_locale
    I18n.locale = cookies[:locale] || 'en'
  end

end
