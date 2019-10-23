module Getter
  class << self
    def session
      CurrentSession.session
    end

    def total_attempts
      Statistic.total_attempts
    end

    def used_attempts
      Statistic.used_attempts
    end

    def total_hints
      Statistic.total_hints
    end

    def used_hints
      Statistic.used_hints
    end

    def difficulty
      level
    end

    def difficulty_name
      current_game.difficulty_name
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
      session[:level]
    end

    def player_name
      session[:player_name].capitalize
    end

    def result
      session[:result]
    end

    def hint
      current_game.use_hint
    end

    def taken_hints
      session[:take_hints]
    end

    def sort_stats
      Statistic.sort_stats
    end

    def secret_code
      current_game.secret_code.join
    end
  end
end
