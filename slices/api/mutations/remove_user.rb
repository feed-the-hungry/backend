# frozen_string_literal: true

require_relative 'base_mutation'

module Mutations
  class RemoveUser < Mutations::BaseMutation
    type Boolean

    argument :id, ID, required: true

    def resolve(id:)
      result = ::RemoveUser.new.call(id)

      !result.user.nil?
    end
  end
end
