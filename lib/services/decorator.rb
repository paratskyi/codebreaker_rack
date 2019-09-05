module Decorator
  def self.full_attempts_info
    "#{Getter.used_attempts}/#{Getter.total_attempts}"
  end

  def self.full_hints_info
    "#{Getter.used_hints}/#{Getter.total_hint}"
  end

  def self.full_difficulty_info(difficulty_name, difficulty)
    "#{difficulty_name.capitalize} - #{difficulty[:attempts]} attempts - #{difficulty[:hints]} hints"
  end
end
