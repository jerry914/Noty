# spec/models/note_spec.rb
require_relative '../spec_helper'

RSpec.describe Note do
  it 'is valid with valid attributes' do
    account = Account.create(name: 'Test Account', email: 'test@example.com')
    collection = Collection.create(name: 'Test Collection', account_id: account.id)
    note = Note.new(title: 'Test Note', content: 'This is a test note.', account_id: account.id, collection_id: collection.id)
    expect(note).to be_valid
  end

  it 'is not valid without a title' do
    note = Note.new(content: 'This is a test note.')
    expect(note).not_to be_valid
  end
end
