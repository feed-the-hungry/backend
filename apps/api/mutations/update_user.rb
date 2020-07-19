# frozen_string_literal: true

require_relative 'base_mutation'
require_relative '../types/user_input'
require_relative '../types/user'

module Mutations
  class UpdateUser < Mutations::BaseMutation
    argument :id, ID, required: true
    argument :input, Types::UserInput, required: true

    field :user, Types::User, null: true

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
