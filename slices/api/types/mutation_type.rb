# frozen_string_literal: true

require_relative 'base_object'
require_relative '../mutations/add_feed'
require_relative '../mutations/remove_feed'
require_relative '../mutations/update_feed'
require_relative '../mutations/add_user'
require_relative '../mutations/remove_user'
require_relative '../mutations/update_user'

module API
  module Types
    class MutationType < BaseObject
      graphql_name 'Mutation'

      field :add_feed, mutation: Mutations::AddFeed

      field :remove_feed, mutation: Mutations::RemoveFeed

      field :update_feed, mutation: Mutations::UpdateFeed

      field :add_user, mutation: Mutations::AddUser

      field :remove_user, mutation: Mutations::RemoveUser

      field :update_user, mutation: Mutations::UpdateUser
    end
  end
end
