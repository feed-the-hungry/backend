# frozen_string_literal: true

require_relative 'base_mutation'
require_relative '../types/entry_input'
require_relative '../types/entry'

module Mutations
  class AddEntry < Mutations::BaseMutation
    basic_add_arguments(return_field_name: :entry, return_type: Types::Entry, input_type: Types::EntryInput)

    def resolve(input:)
      result = ::AddEntry.new.call(input)

      if result.successful?
        {
          entry: result.entry
        }
      else
        raise_invalid_resource('entry', result.errors)
      end
    end
  end
end
