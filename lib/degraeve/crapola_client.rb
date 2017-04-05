module Degraeve
  require 'nokogiri'
  require 'uri'

  class CrapolaClient
    attr_accessor :language

    def initialize(language:)
      @language = language
    end

    def call(message:)
      response = Faraday.get "http://www.degraeve.com/cgi-bin/babel.cgi?d=#{language}&w=#{encoded_message(message)}"
      document = Nokogiri::HTML(response.body)
      translated = document.search('p')
      content = translated[0].content if translated
      content.gsub("\n","") if content
    rescue Faraday::Error => e
      default_erro_message(e.message)
    rescue TypeError => e
      default_erro_message(e.message)
    rescue StandardError => e
      default_erro_message(e.message)
    end

    private

    def encoded_message(message)
      URI::encode(message)
    end

    def default_erro_message(error)
      "Message not delivery! Reason: #{error}"
    end
  end
end
