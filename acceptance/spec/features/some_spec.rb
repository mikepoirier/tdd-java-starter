require_relative '../spec_helper'

describe 'some app' do
  describe 'greeting api' do
    it 'greets users without a name' do
      resp = get some_app_url('/greeting')

      expect(resp[:greeting]).to eq 'Hello, World!'
    end

    it 'greets users with a name' do
      resp1 = get some_app_url('/greeting/user')
      encoded_user = ERB::Util.url_encode 'another user'
      resp2 = get some_app_url("/greeting/#{encoded_user}")

      expect(resp1[:greeting]).to eq 'Hello, User!'
      expect(resp2[:greeting]).to eq 'Hello, Another User!'
    end
  end
end