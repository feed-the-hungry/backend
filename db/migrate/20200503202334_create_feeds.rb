# frozen_string_literal: true

ROM::SQL.migration do
  up do
    execute 'CREATE EXTENSION IF NOT EXISTS "uuid-ossp"'

    create_table :feeds do
      column(
        :id,
        'uuid',
        null: false,
        primary_key: true,
        default: Sequel.function(:uuid_generate_v4)
      )

      column :title,      String,   null: false
      column :url,        String,   null: false
      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false

      index :url, unique: true
    end
  end

  down do
    drop_table :feeds

    execute 'DROP EXTENSION IF EXISTS "uuid-ossp"'
  end
end
