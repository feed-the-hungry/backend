# frozen_string_literal: true

workers 2
worker_timeout 30

threads_count = 5
threads threads_count, threads_count

preload_app!

port        3000, '0.0.0.0'
environment ENV.fetch('HANAMI_ENV', 'development')

before_fork do
  Hanami.app['persistence.rom'].disconnect
end
