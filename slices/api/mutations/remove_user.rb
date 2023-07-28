# frozen_string_literal: true

require_relative 'base_mutation'

module API
  module Mutations
    class RemoveUser < BaseMutation
      type Boolean

      argument :id, ID, required: true

      def resolve(id:)
        result = FeedTheHungry::Interactors::RemoveUser.new.call(id)

        !result.user.nil?
      end
    end
  end
end
