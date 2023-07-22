# frozen_string_literal: true

require_relative 'base_mutation'
require_relative '../types/user_input'
require_relative '../types/user'

module Mutations
  class AddUser < Mutations::BaseMutation
    basic_add_arguments(return_field_name: :user, return_type: Types::User, input_type: Types::UserInput)

    def resolve(input:)
      result = ::AddUser.new.call(input)

      if result.successful?
        {
          feed: result.user
        }
      else
        raise_invalid_resource('user', result.errors)
      end
    end
  end
end
