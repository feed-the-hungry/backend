# frozen_string_literal: true

require_relative 'base_input_object'
require_relative 'email'

module API
  module Types
    class UserInput < BaseInputObject
      argument :name, String, required: true
      argument :email, Types::Email, required: true
    end
  end
end
