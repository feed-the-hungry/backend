# frozen_string_literal: true

require_relative 'base_mutation'
require_relative '../types/user_input'
require_relative '../types/user'

module Mutations
  class UpdateUser < Mutations::BaseMutation
    basic_update_arguments(
      return_field_name: :user,
      return_type: Types::User,
      input_type: Types::UserInput
    )

    def resolve(id:, input:)
      result = ::UpdateUser.new.call(id, input)

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
