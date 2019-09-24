module Processor
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
    session.clear
    Output.show_page('index.html.erb')
  end

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
    CurrentSession.session
  end

  def save_result
    current_game.save_result
  end

  def new_codebreaker_game
    CodebreakerParatskiy.run_game(Getter.player_name, Getter.difficulty)
    CurrentGame.game
  end

  def submit_answer
    session[:result] = current_game.result(@request['number'])
    session[:lost?] = current_game.lost?
    session[:won?] = current_game.won?(result)
    redirect(game_redirect_to)
  end

  def take_hint
    Getter.taken_hints.push(Getter.hint) unless current_game.hints.zero?
    redirect('/game')
  end
end
