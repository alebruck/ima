class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_user

  private

  def set_user

    redirect_to new_user_session_path unless session[:current_user].present?
  end
end
