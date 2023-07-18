# frozen_string_literal: true

source 'https://rubygems.org'

gem 'feedvalidator'
gem 'graphql', '2.0.24'
gem 'hanami', '~> 1.3'
gem 'i18n'
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
  gem 'rspec'
  gem 'vcr', require: false
  gem 'webmock', require: false
end
