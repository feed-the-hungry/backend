# frozen_string_literal: true

module FeedTheHungry
  module Enumerations
    module FeedKind
      TEXT = 'text'
      AUDIO = 'audio'

      def self.all
        [TEXT, AUDIO]
      end
    end
  end
end
