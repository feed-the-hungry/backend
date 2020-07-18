# frozen_string_literal: true

source 'https://rubygems.org'

gem 'feedvalidator'
gem 'graphql'
gem 'hanami',             '~> 1.3'
gem 'hanami-model',       '~> 1.3'
gem 'hanami-validations', '~> 1.3'
gem 'i18n'
gem 'pg'
gem 'puma'
gem 'rake'

group :development do
  gem 'hanami-webconsole'
  gem 'lefthook'
  gem 'rubocop', require: false
  gem 'shotgun', platforms: :ruby
end

group :test, :development do
  gem 'dotenv', '~> 2.4'
end

group :test do
  gem 'codecov', require: false
  gem 'rspec'
  gem 'vcr', require: false
  gem 'webmock', require: false
end
