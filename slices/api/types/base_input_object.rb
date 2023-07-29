# frozen_string_literal: true

require 'graphql'

module API
  module Types
    class BaseInputObject < GraphQL::Schema::InputObject
    end
  end
end
