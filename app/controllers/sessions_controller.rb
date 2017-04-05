class SessionsController < ApplicationController
  skip_before_action :set_user, only: [:new, :create]

  def new
    @languages = ["Yoda", "Valley Girl", "Binary Code"]
  end

  def destroy
    session[:current_user] = nil
    session[:current_language] = nil

    ActionCable.server.broadcast 'messages',
      conection: {
        user: params[:user],
        disconected: true
      }

    redirect_to new_user_session_path
  end

  def create
    session[:current_user] = params[:user]
    session[:current_language] = params[:language]

    ActionCable.server.broadcast 'messages',
      conection: {
        user: params[:user],
        conected: true
      }

    redirect_to root_path
  end
end
