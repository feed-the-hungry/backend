# frozen_string_literal: true

ROM::SQL.migration do
  change do
    create_table :users do
      column(
        :id,
        'uuid',
        null: false,
        primary_key: true,
        default: Sequel.function(:uuid_generate_v4)
      )

      column :name,       String,   null: false
      column :email,      String,   null: false
      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false

      index :email, unique: true
    end
  end
end
