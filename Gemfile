# frozen_string_literal: true

source 'https://rubygems.org'

gem 'faraday'
gem 'faraday-follow_redirects'
gem 'graphql', '2.5.11'
gem 'hanami', '~> 2.2'
gem 'hanami-controller', '~> 2.2'
gem 'hanami-validations', '~> 2.2'
gem 'i18n'
gem 'nokogiri'
gem 'pg'
gem 'puma'
gem 'rake'
gem 'rom', '~> 5.4'
gem 'rom-sql', '~> 3.7'
gem 'rss'
gem 'sidekiq'
gem 'sidekiq-scheduler'

group :development do
  gem 'hanami-webconsole'
  gem 'lefthook'
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rspec', require: false
  gem 'shotgun', platforms: :ruby
end

group :test, :development do
  gem 'dotenv', '~> 3.1'
end

group :test do
  gem 'database_cleaner-sequel', require: false
  gem 'rom-factory', '~> 0.13', require: false
  gem 'rspec'
  gem 'simplecov'
  gem 'simplecov-cobertura'
  gem 'vcr', require: false
  gem 'webmock', require: false
end
