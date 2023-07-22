# frozen_string_literal: true

require 'feed_the_hungry/types'
require 'hanami/settings'

module FeedTheHungry
  class Settings < Hanami::Settings
    # Framework
    setting :log_to_stdout, constructor: Types::Params::Bool, default: false

    # Database
    setting :database_url, constructor: Types::String
  end
end
