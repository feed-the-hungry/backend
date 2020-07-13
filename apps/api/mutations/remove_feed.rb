# frozen_string_literal: true

require_relative 'base_mutation'

module Mutations
  class RemoveFeed < Mutations::BaseMutation
    type Boolean

    argument :id, ID, required: true

    def resolve(id:)
      FeedRepository.new.delete(id) || false
    end
  end
end
