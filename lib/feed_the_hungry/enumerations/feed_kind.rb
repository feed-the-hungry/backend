# frozen_string_literal: true

module FeedKind
  TEXT = 'text'
  AUDIO = 'audio'

  def self.all
    [TEXT, AUDIO]
  end
end
