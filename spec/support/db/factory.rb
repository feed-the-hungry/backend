# frozen_string_literal: true

require 'rom-factory'

Factory = ROM::Factory.configure do |config|
  config.rom = Hanami.app['persistence.rom']
end

Dir[Pathname(__FILE__).dirname.join('../factories/**/*.rb')].each { |file| require file }
