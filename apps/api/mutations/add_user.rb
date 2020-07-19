# frozen_string_literal: true

require_relative 'base_mutation'
require_relative '../types/user_input'
require_relative '../types/user'

module Mutations
  class AddUser < Mutations::BaseMutation
    argument :input, Types::UserInput, required: true

    field :user, Types::User, null: true

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
