# frozen_string_literal: true

require_relative 'base_input_object'
require_relative 'url'

module Types
  class FeedInput < Types::BaseInputObject
    argument :title, String, required: true
    argument :url, Types::Url, required: true
  end
end
