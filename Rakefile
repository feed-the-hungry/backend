# frozen_string_literal: true

require 'rake'
require 'rom/sql/rake_task'
require 'hanami/prepare'

begin
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new(:spec)

  task default: :spec
rescue LoadError # rubocop:disable Lint/SuppressedException
end

namespace :db do
  task :setup do
    FeedTheHungry::App.prepare :persistence

    config = FeedTheHungry::Container['persistence.config']

    ROM::SQL::RakeSupport.env = ROM.container(config)
  end
end
