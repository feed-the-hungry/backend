# frozen_string_literal: true

require_relative 'base_object'
require_relative 'date_time'
require_relative 'url'
require_relative 'feed'

module API
  module Types
    class Entry < BaseObject
      field :id, ID, null: false
      field :guid, Types::Url, null: false
      field :title, String, null: false
      field :description, String, null: false
      field :published_at, Types::DateTime, null: false
      field :created_at, Types::DateTime, null: false
      field :updated_at, Types::DateTime, null: false
    end
  end
end
