# frozen_string_literal: true

source 'https://rubygems.org'

gem 'faraday'
gem 'faraday-follow_redirects'
gem 'graphql', '2.2.3'
gem 'hanami', '~> 2.0'
gem 'hanami-controller', '~> 2.0'
gem 'hanami-validations', '~> 2.0'
gem 'i18n'
gem 'nokogiri'
gem 'pg'
gem 'puma'
gem 'rake'
gem 'rom', '~> 5.3'
gem 'rom-sql', '~> 3.6'
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
  gem 'dotenv', '~> 2.8'
end

group :test do
  gem 'codecov', require: false
  gem 'database_cleaner-sequel', require: false
  gem 'rom-factory', '~> 0.10', require: false
  gem 'rspec'
  gem 'vcr', require: false
  gem 'webmock', require: false
end
