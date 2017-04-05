class MessagesController < ApplicationController
  def create
    translated_message = MessageTranslaterService.run(language: language_code, message: params[:content])
    ActionCable.server.broadcast 'messages',
      chat: {
        message: translated_message,
        user: params[:user],
        language: params[:language]
      }
    head :ok
  end

  private

  def language_code
     params[:language].split(" ")[0].downcase
  end
end
