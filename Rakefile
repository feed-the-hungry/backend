# frozen_string_literal: true

require 'rake'
require 'rom/sql/rake_task'

task :environment do
  require 'hanami/init'
end

begin
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new(:spec)

  task default: :spec
rescue LoadError # rubocop:disable Lint/SuppressedException
end

Rake::Task['db:migrate'].clear

namespace :db do
  task setup: :environment do
    ROM::SQL::RakeSupport.env = FeedTheHungry::Persistence.configuration
  end
end
