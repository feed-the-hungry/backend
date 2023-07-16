# frozen_string_literal: true

ROM::SQL.migration do
  change do
    create_table :user_feeds do
      primary_key(
        :id,
        'uuid',
        null: false,
        default: Sequel.function(:uuid_generate_v4)
      )
      foreign_key :user_id, :users, on_delete: :cascade, null: false, type: :uuid
      foreign_key :feed_id, :feeds, on_delete: :cascade, null: false, type: :uuid

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false

      index %i[user_id feed_id], unique: true
    end
  end
end
