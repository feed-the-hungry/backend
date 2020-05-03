# frozen_string_literal: true

source 'https://rubygems.org'

gem 'graphql'
gem 'hanami',       '~> 1.3'
gem 'hanami-model', '~> 1.3'
gem 'pg'
gem 'puma'
gem 'rake'

group :development do
  gem 'hanami-webconsole'
  gem 'rubocop', require: false
  gem 'shotgun', platforms: :ruby
end

group :test, :development do
  gem 'dotenv', '~> 2.4'
end

group :test do
  gem 'rspec'
end
