# frozen_string_literal: true

require_relative '../../schema'

module Api
  module Controllers
    module Graphql
      class Execute
        include Api::Action

        accept :json

        def call(params)
          query_variables = params[:variables] || {}

          result = Schema.execute(params[:query], variables: query_variables)

          status 200, JSON.generate(result)
        end
      end
    end
  end
end
