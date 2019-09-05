require 'spec_helper'
require './lib/codebreaker_web'

RSpec.describe CodebreakerWeb do
  def app
    Rack::Builder.parse_file('config.ru').first
  end

  context 'with rack env' do
    let(:user_name) { 'John Doe' }
    let(:env) { { 'HTTP_COOKIE' => "user_name=#{user_name}" } }

    it 'returns ok status' do
      get '/', {}, env
      # binding.pry
      expect(last_response.body).to include('Player\'s name:')
    end
  end

  context 'statuses' do
    it 'returns status not found' do
      get '/unknown'
      expect(last_response).to be_not_found
    end

    it 'returns status ok' do
      get '/'
      expect(last_response).to be_ok
    end
  end

  context 'cookies' do
    it 'sets cookies' do
      set_cookie('user_id=123')
      get '/'
      expect(last_request.cookies).to eq('user_id' => '123')
    end
  end

  context 'redirects' do
    it 'redirects' do
      post '/some_url'
      expect(last_response).to be_redirect
      expect(last_response.header['Location']).to eq('/redirect_url')
    end
  end
end
