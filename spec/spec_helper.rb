# frozen_string_literal: true

# Require this file for unit tests
ENV['HANAMI_ENV'] ||= 'test'

require 'hanami/boot'

require_relative 'support/db'
require_relative 'support/rspec'
require_relative 'support/vcr'

Hanami.prepare
