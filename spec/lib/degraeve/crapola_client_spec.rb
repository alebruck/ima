require 'rails_helper'

RSpec.describe Degraeve::CrapolaClient, type: :lib do
  let(:crapola_client) { described_class.new language: 'yoda' }

  describe '#call' do
    let(:message) { "this is a simple message" }

    it 'translates message' do
      VCR.use_cassette 'translate yoda message' do
        expect(crapola_client.call(message: message)).to eq(' A simple message, this is ')
      end
    end
  end
end
