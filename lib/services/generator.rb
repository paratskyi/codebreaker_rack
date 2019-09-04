# frozen_string_literal: true

module Generator
  def self.denger_mark
    '<button type="buttosessionn" class="btn btn-danger marks" disabled>x</button>'
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

  def self.level_options
    options = DIFFICULTIES.map do |difficulty_name, difficulty|
      Generator.difficulty_option(difficulty_name, difficulty)
    end
    options.join
  end

  def self.guess_marks
    guess_marks = ''
    Getter.result.each_char do |guess_mark|
      case guess_mark
      when '+' then guess_marks += success_mark
      when '-' then guess_marks += primary_mark
      end
    end
    (4 - Getter.result.length).times { guess_marks += denger_mark }
    guess_marks
  end

  def self.generate_stats
    stats_element = ''
    index = 0
    while index < Getter.sort_stats.length
      value = Getter.sort_stats[index]
      stats_element += player_information(value, index)
      index += 1
    end
    stats_element
  end

  def self.player_information(value, index)
    "<tr>
      <th scope='row'>#{index + 1}</th>
      <td>#{value[:name]}</td>
      <td>#{value[:difficulty].capitalize}</td>
      <td>#{value[:attempts_used]}/#{value[:attempts_total]}</td>
      <td>#{value[:hints_used]}/#{value[:hints_total]}</td>
      <td>#{value[:date]}</td>
    </tr>"
  end
end
