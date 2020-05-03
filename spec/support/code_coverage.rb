# frozen_string_literal: true

require 'simplecov'

SimpleCov.start do
  add_filter '/spec/'
  add_filter '/config/'
  add_filter '/db/'
end

if ENV['CI'] == 'true'
  require 'codecov'

  SimpleCov.formatter = SimpleCov::Formatter::Codecov
end
