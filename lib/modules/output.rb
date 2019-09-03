# frozen_string_literal: true

module Output
  def self.show_page(template)
    Rack::Response.new(render(template))
  end

  def self.render(template)
    path = File.expand_path("../../views/#{template}", __FILE__)
    ERB.new(File.read(path)).result(binding)
  end

  def self.guess_marks
    return Generator.guess_marks if CurrentSession.session[:result]

    DEFAULT_GUESS_MARKS
  end

  def self.show_hints
    hint_spans = DataHelper.taken_hints.map do |hint|
      Generator.hint_span(hint)
    end
    hint_spans.join
  end
end
