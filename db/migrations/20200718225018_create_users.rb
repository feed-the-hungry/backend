# frozen_string_literal: true

Hanami::Model.migration do
  change do
    create_table :users do
      primary_key(
        :id,
        'uuid',
        null: false,
        default: Hanami::Model::Sql.function(:uuid_generate_v4)
      )

      column :name,       String,   null: false
      column :email,      String,   null: false
      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false

      index :email, unique: true
    end
  end
end
