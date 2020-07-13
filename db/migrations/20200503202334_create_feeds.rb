# frozen_string_literal: true

Hanami::Model.migration do
  change do
    execute 'CREATE EXTENSION IF NOT EXISTS "uuid-ossp"'

    create_table :feeds do
      primary_key(
        :id,
        'uuid',
        null: false,
        default: Hanami::Model::Sql.function(:uuid_generate_v4)
      )

      column :title,      String,   null: false
      column :url,        String,   null: false
      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false

      index :url, unique: true
    end
  end
end
