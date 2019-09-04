# frozen_string_literal: true

module Getter
  def self.session
    CurrentSession.session
  end

  def current_game
    session[:game]
  end

  def self.total_attempts
    DIFFICULTIES[difficulty_name.to_sym][:attempts]
  end

  def self.used_attempts
    DIFFICULTIES[difficulty_name.to_sym][:attempts] - attempts
  end

  def self.total_hint
    DIFFICULTIES[difficulty_name.to_sym][:hints]
  end

  def self.used_hints
    DIFFICULTIES[difficulty_name.to_sym][:hints] - hints
  end

  def self.difficulty
    DIFFICULTIES[level.downcase.to_sym]
  end

  def self.difficulty_name
    session[:game].difficulty_name
  end

  def self.hints
    current_game.hints
  end

  def self.attempts
    current_game.attempts
  end

  def self.current_game
    session[:game]
  end

  def self.level
    session[:level].capitalize
  end

  def self.player_name
    session[:player_name].capitalize
  end

  def self.result
    session[:result]
  end

  def self.hint
    current_game.use_hint
  end

  def self.taken_hints
    session[:take_hints]
  end

  def self.sort_stats
    stats.sort_by { |player| [player[:attempts_total], player[:attempts_used], player[:hints_used]] }
  end

  def self.stats
    current_game.stats
  end

  def self.secret_code
    current_game.secret_code.join
  end
end
