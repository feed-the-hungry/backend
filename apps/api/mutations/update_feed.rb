# frozen_string_literal: true

require_relative 'base_mutation'
require_relative '../types/feed_input'
require_relative '../types/feed'

module Mutations
  class UpdateFeed < Mutations::BaseMutation
    argument :id, ID, required: true
    argument :input, Types::FeedInput, required: true

    field :feed, Types::Feed, null: true

    def resolve(id:, input:)
      result = ::UpdateFeed.new.call(id, input)

      if result.successful?
        {
          feed: result.feed
        }
      else
        raise_invalid_resource('feed', result.errors)
      end
    end
  end
end
