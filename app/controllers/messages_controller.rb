class MessagesController < ApplicationController
  def create
    ActionCable.server.broadcast 'messages',
      message: params[:content],
      user: params[:user],
      language: params[:language]
    head :ok
  end
end
