module Generator
  class << self
    def danger_mark
      '<button type="button" class="btn btn-danger marks" disabled>x</button>'
    end

    def primary_mark
      '<button type="button" class="btn btn-primary marks" disabled>-</button>'
    end

    def success_mark
      '<button type="button" class="btn btn-success marks" disabled>+</button>'
    end

    def hint_span(hint)
      "<span class='badge badge-light'>#{hint}</span>\n"
    end

    def difficulty_option(difficulty_name, difficulty)
      "<option value='#{difficulty_name}'>#{Decorator.full_difficulty_info(difficulty_name, difficulty)}</option>"
    end

    def level_options
      options = DIFFICULTIES.map do |difficulty_name, difficulty|
        Generator.difficulty_option(difficulty_name, difficulty)
      end
      options.join
    end

    def guess_marks
      guess_marks = ''
      Getter.result.each_char do |guess_mark|
        guess_marks += if guess_mark == SUCCESS_MARK
                         success_mark
                       else
                         primary_mark
                       end
      end
      (4 - Getter.result.length).times { guess_marks += danger_mark }
      guess_marks
    end

    def generate_stats
      stats_element = ''
      index = 0
      while index < Getter.sort_stats.length
        value = Getter.sort_stats[index]
        stats_element += player_information(value, index)
        index += 1
      end
      stats_element
    end

    def player_information(value, index)
      "<tr>
        <th scope='row'>#{index + 1}</th>
        <td>#{value[:name]}</td>
        <td>#{value[:difficulty].capitalize}</td>
        <td>#{value[:used_attempts]}/#{value[:total_attempts]}</td>
        <td>#{value[:used_hints]}/#{value[:total_hints]}</td>
        <td>#{value[:date]}</td>
      </tr>"
    end
  end
end
