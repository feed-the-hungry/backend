# frozen_string_literal: true

require_relative 'base_object'
require_relative '../mutations/add_feed'
require_relative '../mutations/remove_feed'
require_relative '../mutations/update_feed'

module Types
  class MutationType < Types::BaseObject
    graphql_name 'Mutation'

    field :add_feed, mutation: Mutations::AddFeed

    field :remove_feed, mutation: Mutations::RemoveFeed

    field :update_feed, mutation: Mutations::UpdateFeed
  end
end
