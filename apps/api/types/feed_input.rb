# frozen_string_literal: true

require_relative 'base_input_object'
require_relative 'url'
require_relative 'feed_kind'

module Types
  class FeedInput < Types::BaseInputObject
    argument :user_id, ID, required: true
    argument :title, String, required: true
    argument :kind, Types::FeedKind, required: true
    argument :url, Types::Url, required: true
  end
end
