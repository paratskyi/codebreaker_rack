# frozen_string_literal: true

module Decorator
  def self.full_attempts_info
    "#{DataHelper.used_attempts}/#{DataHelper.total_attempts}"
  end

  def self.full_hints_info
    "#{DataHelper.used_hints}/#{DataHelper.total_hint}"
  end

  def self.full_difficulty_info(difficulty_name, difficulty)
    "#{difficulty_name.capitalize} - #{difficulty[:attempts]} attempts - #{difficulty[:hints]} hints"
  end

  def self.level_options
    options = DIFFICULTIES.map do |difficulty_name, difficulty|
      Generator.difficulty_option(difficulty_name, difficulty)
    end
    options.join
  end
end
