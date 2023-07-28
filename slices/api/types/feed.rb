# frozen_string_literal: true

require_relative 'base_object'
require_relative 'date_time'
require_relative 'url'
require_relative 'feed_kind'
require_relative 'entry'

module API
  module Types
    class Feed < BaseObject
      field :id, ID, null: false
      field :title, String, null: false
      field :url, Types::Url, null: false
      field :kind, Types::FeedKind, null: false
      field :created_at, Types::DateTime, null: false
      field :updated_at, Types::DateTime, null: false

      field :entries, Types::Entry.connection_type, null: true, connection: true
    end
  end
end
