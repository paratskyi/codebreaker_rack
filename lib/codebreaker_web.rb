# frozen_string_literal: true

require_relative 'dependencies'
class CodebreakerWeb
  def self.call(env)
    new(env).response.finish
  end

  def initialize(env)
    @request = Rack::Request.new(env)
  end

  def response
    return process_routs if ROUTS.include?(path)

    Rack::Response.new('Not Found', 404)
  end

  def process_routs
    send(ROUTS[path])
  end

  def path
    @request.path
  end

  def lost
    show_page('lost.html.erb')
  end

  def rules
    show_page('rules.html.erb')
  end

  def won
    save_result
    show_page('won.html.erb')
  end

  def statistic
    show_page('statistic.html.erb')
  end

  def index
    show_page('index.html.erb')
  end

  def new_game
    redirect('/session_start')
  end

  def difficulty
    DataHelper.new(session).difficulty
  end

  def session_start
    update_session('game', CodebreakerParatskiy.run_game(player_name, difficulty)) unless session_present?(:name)
    update_session('take_hints', [])
    redirect('/game')
  end

  def game
    return show_page('game.html.erb') if session_present?(:game)

    update_session('player_name')
    update_session('level')
    redirect('/session_start')
  end

  def redirect(path)
    Rack::Response.new { |response| response.redirect(path) }
  end

  def update_session(name, value = @request[name])
    @request.session[name.to_sym] = value
  end

  def game_redirect_to
    if lost?
      '/lost'
    elsif won?
      '/won'
    else
      '/game'
    end
  end

  def save_result
    current_game.save_result
  end

  def generate_stats
    stats_element = ''
    index = 0
    while index < sort_stats.length
      value = sort_stats[index]
      stats_element += "<tr>
                          <th scope='row'>#{index + 1}</th>
                          <td>#{value[:name]}</td>
                          <td>#{value[:difficulty].capitalize}</td>
                          <td>#{value[:attempts_used]}/#{value[:attempts_total]}</td>
                          <td>#{value[:hints_used]}/#{value[:hints_total]}</td>
                          <td>#{value[:date]}</td>
                        </tr>"
      index += 1
    end
    stats_element
  end

  def sort_stats
    stats.sort_by { |player| [player[:attempts_total], player[:attempts_used], player[:hints_used]] }
  end

  def stats
    current_game.stats
  end

  def show_page(template)
    Rack::Response.new(render(template))
  end

  def render(template)
    path = File.expand_path("../views/#{template}", __FILE__)
    ERB.new(File.read(path)).result(binding)
  end

  def submit_answer
    session[:result] = current_game.result(@request['number'])
    session[:lost?] = current_game.lost?
    session[:won?] = current_game.won?(result)
    redirect(game_redirect_to)
  end

  def guess_marks
    return Generator.guess_marks(result) if result

    DEFAULT_GUESS_MARKS
  end

  def show_hints
    hint_spans = taken_hints.map do |hint|
      Generator.hint_span(hint)
    end
    hint_spans.join
  end

  def take_hint
    taken_hints.push(hint) unless current_game.hints.zero?
    redirect('/game')
  end

  def taken_hints
    session[:take_hints]
  end

  def hint
    current_game.use_hint
  end

  def won?
    session[:won?]
  end

  def lost?
    session[:lost?]
  end

  def level_options
    options = DIFFICULTIES.map do |difficulty_name, difficulty|
      Generator.difficulty_option(difficulty_name, difficulty)
    end
    options.join
  end
  
  def full_attempts_info
    "#{DataHelper.new(session).used_attempts}/#{DataHelper.new(session).total_attempts}"
  end
  
  def full_hints_info
    "#{DataHelper.new(session).used_hints}/#{DataHelper.new(session).total_hint}"
  end
  
  def result
    session[:result]
  end

  def current_game
    session[:game]
  end

  def session
    @request.session
  end

  

  def level
    session[:level].capitalize
  end

  def player_name
    session[:player_name].capitalize
  end

  private

  def session_present?(key)
    @request.session.key?(key)
  end

  def secret_code
    current_game.secret_code.join
  end
end
