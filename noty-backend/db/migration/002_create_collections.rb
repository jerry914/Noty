require 'sequel'

Sequel.migration do
  change do
    create_table(:collections) do
      primary_key :id
      foreign_key :account_id, :accounts, null: false, on_delete: :cascade
      String :name, null: false
      Text :prompt
      Timestamp :created_at, default: Sequel::CURRENT_TIMESTAMP
      Timestamp :updated_at, default: Sequel::CURRENT_TIMESTAMP

      index :account_id
    end
  end
end
