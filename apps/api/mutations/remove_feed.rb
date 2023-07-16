# frozen_string_literal: true

require_relative 'base_mutation'

module Mutations
  class RemoveFeed < Mutations::BaseMutation
    type Boolean

    argument :id, ID, required: true

    def resolve(id:)
      FeedTheHungry::Repositories::FeedRepository.new.delete(id) || false
    end
  end
end
