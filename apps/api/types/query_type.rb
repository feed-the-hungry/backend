# frozen_string_literal: true

require_relative 'base_object'

module Types
  class QueryType < Types::BaseObject
    graphql_name 'Query'
  end
end
