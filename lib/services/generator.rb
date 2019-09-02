# frozen_string_literal: true

module Generator
  def self.denger_mark
    '<button type="button" class="btn btn-danger marks" disabled>x</button>'
  end

  def self.primary_mark
    '<button type="button" class="btn btn-primary marks" disabled>-</button>'
  end

  def self.success_mark
    '<button type="button" class="btn btn-success marks" disabled>+</button>'
  end

  def self.hint_span(hint)
    "<span class='badge badge-light'>#{hint}</span>\n"
  end

  def self.difficulty_option(difficulty_name, difficulty)
    "<option value='#{difficulty_name}'>#{Decorator.full_difficulty_info(difficulty_name, difficulty)}</option>"
  end

  def self.guess_marks(result)
    guess_marks = ''
    result.each_char do |guess_mark|
      case guess_mark
      when '+' then guess_marks += Generator.success_mark
      when '-' then guess_marks += Generator.primary_mark
      end
    end
    (4 - result.length).times { guess_marks += Generator.denger_mark }
    guess_marks
  end
end
