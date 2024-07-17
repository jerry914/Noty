# spec/services/authorization_service_spec.rb
require_relative '../spec_helper'

RSpec.describe AuthorizationService do
  it 'authorizes a account to access their own resource' do
    account = Account.create(name: 'Test Account', email: 'test@example.com')
    collection = Collection.create(name: 'Test Collection', account_id: account.id)
    note = Note.create(title: 'Test Note', content: 'This is a test note.', account_id: account.id, collection_id: collection.id)
    service = AuthorizationService.new(account, note)
    expect(service.authorized?).to be true
  end

  it 'does not authorize a account to access another account’s resource' do
    account1 = Account.create(name: 'Test Account 1', email: 'test1@example.com')
    account2 = Account.create(name: 'Test Account 2', email: 'test2@example.com')
    collection1 = Collection.create(name: 'Test Collection', account_id: account1.id)
    note = Note.create(title: 'Test Note', content: 'This is a test note.', account_id: account1.id, collection_id: collection1.id)
    service = AuthorizationService.new(account2, note)
    expect(service.authorized?).to be false
  end
end
