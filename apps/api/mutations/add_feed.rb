# frozen_string_literal: true

require_relative 'base_mutation'
require_relative '../types/feed_input'
require_relative '../types/feed'
require_relative '../validators/feed_validator'

module Mutations
  class AddFeed < Mutations::BaseMutation
    argument :input, Types::FeedInput, required: true

    field :feed, Types::Feed, null: true

    def resolve(input:)
      result = Api::Validators::FeedValidator.new(input).validate

      if result.success?
        {
          feed: FeedRepository.new.create(input)
        }
      else
        raise_invalid_resource('feed', result)
      end
    end
  end
end