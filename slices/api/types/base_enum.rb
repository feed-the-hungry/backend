# frozen_string_literal: true

require 'graphql'

module API
  module Types
    class BaseEnum < GraphQL::Schema::Enum
    end
  end
end
