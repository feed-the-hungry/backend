# frozen_string_literal: true

Hanami::Model.migration do
  change do
    alter_table :feeds do
      add_column :kind, String, null: false

      set_column_default :kind, 'text'
    end
  end
end
