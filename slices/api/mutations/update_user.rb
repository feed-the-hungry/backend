# frozen_string_literal: true

require_relative 'base_mutation'
require_relative '../types/user_input'
require_relative '../types/user'

module API
  module Mutations
    class UpdateUser < BaseMutation
      basic_update_arguments(
        return_field_name: :user,
        return_type: Types::User,
        input_type: Types::UserInput
      )

      def resolve(id:, input:)
        result = FeedTheHungry::Interactors::UpdateUser.new.call(id, input.to_h)

        if result.successful?
          {
            user: result.user
          }
        else
          raise_invalid_resource('user', result.errors)
        end
      end
    end
  end
end
