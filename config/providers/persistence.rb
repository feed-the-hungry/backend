# frozen_string_literal: true

Hanami.app.register_provider :persistence, namespace: true do
  prepare do
    require 'rom-changeset'
    require 'rom/core'
    require 'rom/sql'

    rom_config = ROM::Configuration.new(
      :sql,
      target['settings'].database_url,
      { migrator: { path: 'db/migrate' } }
    )

    rom_config.plugin(:sql, relations: :instrumentation) do |plugin_config|
      plugin_config.notifications = target['notifications']
    end

    rom_config.plugin(:sql, relations: :auto_restrictions)
    rom_config.plugin(:sql, command: :timestamps)

    register 'config', rom_config
    register 'db', rom_config.gateways[:default].connection
  end

  start do
    config = target['persistence.config']
    config.auto_registration(
      target.root.join('lib/feed_the_hungry/persistence'),
      namespace: 'FeedTheHungry::Persistence'
    )

    register 'rom', ROM.container(config)
  end
end
