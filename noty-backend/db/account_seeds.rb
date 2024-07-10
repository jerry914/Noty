# db/seeds.rb

require_relative '../models/role'
require_relative '../models/account'

# Define the role descriptions
role_descriptions = ['admin', 'member']

# Iterate over the descriptions and create roles if they don't exist
role_descriptions.each do |desc|
  Noty::Role.find_or_create(name: desc)
end

admin_user_data = {
  "name": " ",
  "email": ENV['ADMIN_EMAIL'],
  "roles": [
    "admin"
    ]
}

# Add a new account with the provided data
Noty::Account.add_account(admin_user_data)
