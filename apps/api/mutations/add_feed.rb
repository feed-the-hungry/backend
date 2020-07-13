# frozen_string_literal: true

require_relative 'base_mutation'
require_relative '../types/feed_input'
require_relative '../types/feed'

module Mutations
  class AddFeed < Mutations::BaseMutation
    argument :input, Types::FeedInput, required: true

    field :feed, Types::Feed, null: true

    def resolve(input:)
      {
        feed: FeedRepository.new.create(input)
      }
    end
  end
end
