# frozen_string_literal: true

require_relative 'types/query_type'
require_relative 'types/mutation_type'

class Schema < GraphQL::Schema
  query Types::QueryType
  mutation Types::MutationType
end
