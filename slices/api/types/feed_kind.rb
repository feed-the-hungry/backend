# frozen_string_literal: true

require_relative 'base_enum'

module Types
  class FeedKind < Types::BaseEnum
    description 'Kinds of feed'

    value 'TEXT', ::FeedKind::TEXT, value: ::FeedKind::TEXT
    value 'AUDIO', ::FeedKind::AUDIO, value: ::FeedKind::AUDIO
  end
end
