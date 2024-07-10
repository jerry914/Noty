require 'sequel'

Sequel.migration do
  change do
    create_table(:accounts) do
      primary_key :id
      String :name, null: false
      String :email, null: false, unique: true
      Text :access_token
      Text :refresh_token
      Text :avatar
      Text :llms_secret
      Timestamp :created_at, default: Sequel::CURRENT_TIMESTAMP
      Timestamp :updated_at, default: Sequel::CURRENT_TIMESTAMP
      Timestamp :last_login

      index :email, unique: true
    end
  end
end
