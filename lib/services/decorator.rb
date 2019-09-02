# frozen_string_literal: true

module Decorator
  def self.full_difficulty_info(difficulty_name, difficulty)
    "#{difficulty_name.capitalize} - #{difficulty[:attempts]} attempts - #{difficulty[:hints]} hints"
  end

  def self.full_hints_info
    "#{used_hints}/#{total_hint}"
  end
end
