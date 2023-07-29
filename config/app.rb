# frozen_string_literal: true

begin
  require 'break'
rescue LoadError => e
  raise unless e.path == 'break'
end

require 'hanami'

module FeedTheHungry
  class App < Hanami::App
  end
end
