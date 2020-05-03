# frozen_string_literal: true

require_relative './environment'

workers 2
worker_timeout 30

threads_count = 5
threads threads_count, threads_count

preload_app!

rackup      DefaultRackup
port        3000, '0.0.0.0'
environment ENV.fetch('RACK_ENV') { 'development' }

on_worker_boot do
  Hanami.boot
end
