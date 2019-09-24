require 'spec_helper'
require './lib/codebreaker_web'

RSpec.describe CodebreakerWeb do
  before do
    CodebreakerParatskiy.run_game('test', 'easy')
  end

  let(:game) { CurrentGame.game }

  def app
    Rack::Builder.parse_file('config.ru').first
  end

  before do
    env 'rack.session', player_name: 'test', level: 'easy'
    get '/session_start'
  end

  describe '#render' do
    context 'when correct route path' do
      it 'returns introduction page' do
        get '/'
        expect(last_response.body).to include('introduction')
      end

      it 'returns correct page' do
        ROUTS_TEST.each do |route|
          get "/#{route}"
          expect(last_response.body).to include(route)
        end
      end
    end

    context 'when incorrect route path' do
      it 'returns not_found page' do
        get '/incorrect_rout'
        expect(last_response.body).to include('Not Found')
      end
    end
  end

  describe '#session' do
    context 'when session set' do
      it 'return player name' do
        expect(last_request.session[:player_name]).to eq('test')
      end
      it 'return level name' do
        expect(last_request.session[:level]).to eq('easy')
      end
    end
  end

  describe '#redirect' do
    context 'when correct route path' do
      it 'redirect to game when game continue' do
        last_request.session[:game] = game
        allow(game).to receive(:result).and_return('')
        env 'rack.session', game: game
        post '/submit_answer'
        expect(last_response).to be_redirect
        expect(last_response.header['Location']).to eq('/game')
      end

      it 'redirect to won when won' do
        last_request.session[:game] = game
        allow(game).to receive(:result).and_return('++++')
        env 'rack.session', game: game
        post '/submit_answer'
        expect(last_response).to be_redirect
        expect(last_response.header['Location']).to eq('/won')
      end

      it 'redirect to lost when lost' do
        allow(game).to receive(:result).and_return('')
        game.attempts = 0
        env 'rack.session', game: game
        post '/submit_answer'
        expect(last_response).to be_redirect
        expect(last_response.header['Location']).to eq('/lost')
      end

      it 'redirect to session_start when start new game' do
        post '/new_game'
        expect(last_response).to be_redirect
        expect(last_response.header['Location']).to eq('/session_start')
      end

      it 'redirect to game when session set' do
        post '/session_start'
        expect(last_response).to be_redirect
        expect(last_response.header['Location']).to eq('/game')
      end

      it 'redirect to game when session set' do
        post '/session_start'
        expect(last_response).to be_redirect
        expect(last_response.header['Location']).to eq('/game')
      end
    end
  end

  describe '#game' do
    context 'when player take hint' do
      it 'pushes hint to taken hints' do
        post '/take_hint'
        expect(Getter.taken_hints).not_to be_empty
        expect(last_response).to be_redirect
        expect(last_response.header['Location']).to eq('/game')
      end

      it 'not pushes hint to taken hints if hints ended' do
        game.hints = 0
        env 'rack.session', game: game
        post '/take_hint'
        expect(Getter.taken_hints).to be_empty
        expect(last_response).to be_redirect
        expect(last_response.header['Location']).to eq('/game')
      end
    end
  end
end
