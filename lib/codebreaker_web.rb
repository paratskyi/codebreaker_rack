require_relative 'dependencies'

class CodebreakerWeb
  include Processor

  def self.call(env)
    new(env).response.finish
  end

  def initialize(env)
    @request = Rack::Request.new(env)
    CurrentSession.new(@request.session)
  end

  def response
    return process_routs if ROUTS.include?(path)

    Rack::Response.new('Not Found', 404)
  end

  def process_routs
    send(ROUTS[path])
  end

  def path
    @request.path
  end

  def redirect(path)
    Rack::Response.new { |response| response.redirect(path) }
  end

  def new_game
    redirect('/session_start')
  end

  def game_redirect_to
    if lost?
      '/lost'
    elsif won?
      '/won'
    else
      '/game'
    end
  end

  def session_start
    update_session('game', new_codebreaker_game) unless session_present?(:name)
    update_session('take_hints', [])
    redirect('/game')
  end

  def game
    return Output.show_page('game.html.erb') if session_present?(:game)

    update_session('player_name')
    update_session('level')
    redirect('/session_start')
  end

  private
  
  def update_session(name, value = @request[name])
    @request.session[name.to_sym] = value
  end
  
  def session
    @request.session
  end

  def session_present?(key)
    @request.session.key?(key)
  end
end
