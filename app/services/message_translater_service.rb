require './lib/degraeve/crapola_client'

class MessageTranslaterService
  attr_accessor :language

  def self.run(message:, language: 'yoda')
    translator = Degraeve::CrapolaClient.new(language: language)
    translator.call(message: message)
  end
end
