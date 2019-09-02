class DataHelper
  attr_reader

  def initialize(session = '')
    @session = session
  end

  def total_attempts
    DIFFICULTIES[session[:game].difficulty_name.to_sym][:attempts]
  end

  def used_attempts
    DIFFICULTIES[session[:game].difficulty_name.to_sym][:attempts] - attempts
  end


  def total_hint
    DIFFICULTIES[session[:game].difficulty_name.to_sym][:hints]
  end

  def used_hints
    DIFFICULTIES[session[:game].difficulty_name.to_sym][:hints] - hints
  end

  def difficulty
    DIFFICULTIES[level.downcase.to_sym]
  end

  def hints
    current_game.hints
  end

  def attempts
    current_game.attempts
  end

  def current_game
    session[:game]
  end

  def level
    session[:level].capitalize
  end
end