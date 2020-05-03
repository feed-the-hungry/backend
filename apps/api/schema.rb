require_relative 'types/query_type'

class Schema < GraphQL::Schema
  query Types::QueryType
end
