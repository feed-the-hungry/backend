# frozen_string_literal: true

require_relative 'base_enum'

module API
  module Types
    class FeedKind < Types::BaseEnum
      description 'Kinds of feed'

      value 'TEXT', FeedTheHungry::Enumerations::FeedKind::TEXT, value: FeedTheHungry::Enumerations::FeedKind::TEXT
      value 'AUDIO', FeedTheHungry::Enumerations::FeedKind::AUDIO, value: FeedTheHungry::Enumerations::FeedKind::AUDIO
    end
  end
end
