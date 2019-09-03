# frozen_string_literal: true

class CurrentSession
  def initialize(session)
    @@session = session
  end

  def self.session
    @@session
  end
end
