# frozen_string_literal: true

require_relative '../../schema'

module Api
  module Actions
    module Graphql
      class Execute < Api::Action
        accept :json

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
