# frozen_string_literal: true

module FeedTheHungry
  class Routes < Hanami::Application::Routes
    slice :api, at: '/' do
      post '/graphql', to: 'graphql#execute'
    end
  end
end
