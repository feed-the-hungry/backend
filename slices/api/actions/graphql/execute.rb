# frozen_string_literal: true

require_relative '../../schema'

module API
  module Actions
    module Graphql
      class Execute < API::Action
        format :json

        def handle(request, response)
          query_variables = request.params[:variables] || {}

          result = Schema.execute(request.params[:query], variables: query_variables)

          response.body = JSON.generate(result)
          response.status = 200
        end
      end
    end
  end
end
