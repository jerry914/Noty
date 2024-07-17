# spec/models/collection_spec.rb
require_relative '../spec_helper'

RSpec.describe Collection do
  it 'is valid with valid attributes' do
    account = Account.create(name: 'Test Account', email: 'test@example.com')
    collection = Collection.new(name: 'Test Collection', account_id: account.id)
    expect(collection).to be_valid
  end

  it 'is not valid without a name' do
    collection = Collection.new(account_id: 1)
    expect(collection).not_to be_valid
  end
end
