require_relative '../../schema'

module Api
  module Controllers
    module Graphql
      class Execute
        include Api::Action

        def call(params)
          query_variables = params[:variables] || {}

          result = Schema.execute(params[:query], variables: query_variables)

          self.body = JSON.generate(result)
        end
      end
    end
  end
end
