require_relative 'dependencies'

class CodebreakerWeb
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

  def lost
    Output.show_page('lost.html.erb')
  end

  def rules
    Output.show_page('rules.html.erb')
  end

  def won
    save_result
    Output.show_page('won.html.erb')
  end

  def statistic
    Output.show_page('statistic.html.erb')
  end

  def index
    Output.show_page('index.html.erb')
  end

  def new_game
    redirect('/session_start')
  end

  def session_start
    update_session('game', new_codebreaker_game) unless session_present?(:name)
    update_session('take_hints', [])
    redirect('/game')
  end

  def new_codebreaker_game
    CodebreakerParatskiy.run_game(Getter.player_name, Getter.difficulty)
  end

  def game
    return Output.show_page('game.html.erb') if session_present?(:game)

    update_session('player_name')
    update_session('level')
    redirect('/session_start')
  end

  def redirect(path)
    Rack::Response.new { |response| response.redirect(path) }
  end

  def update_session(name, value = @request[name])
    @request.session[name.to_sym] = value
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

  def save_result
    current_game.save_result
  end

  def submit_answer
    # binding.pry
    session[:result] = current_game.result(@request['number'])
    session[:lost?] = current_game.lost?
    session[:won?] = current_game.won?(result)
    redirect(game_redirect_to)
  end

  def take_hint
    Getter.taken_hints.push(Getter.hint) unless current_game.hints.zero?
    redirect('/game')
  end

  private
  
  def won?
    session[:won?]
  end

  def lost?
    session[:lost?]
  end

  def result
    session[:result]
  end

  def current_game
    session[:game]
  end

  def session
    @request.session
  end

  def session_present?(key)
    @request.session.key?(key)
  end
end
