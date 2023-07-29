# frozen_string_literal: true

ROM::SQL.migration do
  change do
    create_table :entries do
      column(
        :id,
        'uuid',
        null: false,
        primary_key: true,
        default: Sequel.function(:uuid_generate_v4)
      )
      foreign_key :feed_id, :feeds, on_delete: :cascade, null: false, type: :uuid

      column :guid,         String, null: false
      column :title,        String, null: false
      column :description,  String, null: false
      column :published_at, DateTime, null: false
      column :created_at,   DateTime, null: false
      column :updated_at,   DateTime, null: false

      index %i[feed_id guid], unique: true
    end
  end
end
