# frozen_string_literal: true

require_relative 'base_mutation'
require_relative '../types/feed_input'
require_relative '../types/feed'

module API
  module Mutations
    class AddFeed < BaseMutation
      basic_add_arguments(return_field_name: :feed, return_type: Types::Feed, input_type: Types::FeedInput)

      def resolve(input:)
        result = FeedTheHungry::Interactors::AddFeed.new.call(input.to_h)

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
end
