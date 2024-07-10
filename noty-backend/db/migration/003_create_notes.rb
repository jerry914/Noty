require 'sequel'

Sequel.migration do
  change do
    create_table(:notes) do
      primary_key :id
      foreign_key :account_id, :accounts, null: false, on_delete: :cascade
      foreign_key :collection_id, :collections, null: false, on_delete: :cascade
      String :title, null: false
      Text :content
      String :status
      Timestamp :created_at, default: Sequel::CURRENT_TIMESTAMP
      Timestamp :updated_at, default: Sequel::CURRENT_TIMESTAMP

      index :account_id
      index :collection_id
    end
  end
end
