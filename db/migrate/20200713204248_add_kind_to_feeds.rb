# frozen_string_literal: true

ROM::SQL.migration do
  up do
    alter_table :feeds do
      add_column :kind, String, null: false

      set_column_default :kind, 'text'
    end
  end

  down do
    alter_table :feeds do
      drop_column :kind
    end
  end
end
