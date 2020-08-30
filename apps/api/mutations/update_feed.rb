# frozen_string_literal: true

require_relative 'base_mutation'
require_relative '../types/feed_input'
require_relative '../types/feed'

module Mutations
  class UpdateFeed < Mutations::BaseMutation
    basic_update_arguments(
      return_field_name: :feed,
      return_type: Types::Feed,
      input_type: Types::FeedInput
    )

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
