# frozen_string_literal: true

require_relative 'base_object'
require_relative 'date_time'
require_relative 'url'

module Types
  class Feed < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :url, Types::Url, null: false
    field :created_at, Types::DateTime, null: false
    field :updated_at, Types::DateTime, null: false
  end
end
