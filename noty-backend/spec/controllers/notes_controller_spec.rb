# spec/controllers/notes_controller_spec.rb
require_relative '../spec_helper'

RSpec.describe 'Notes Controller' do
  before do
    @account = Account.create(name: 'Test Account', email: 'test@example.com')
    header 'Content-Type', 'application/json'
    env 'rack.session', { account_id: @account.id }
  end

  it 'creates a new note' do
    collection = Collection.create(name: 'Test Collection', account_id: @account.id)
    post '/notes', { title: 'Test Note', content: 'This is a test note.', collection_id: collection.id }.to_json
    expect(last_response.status).to eq(201)
    expect(JSON.parse(last_response.body)['message']).to eq('Note created successfully')
  end

  it 'retrieves notes' do
    collection = Collection.create(name: 'Test Collection', account_id: @account.id)
    Note.create(title: 'Test Note', content: 'This is a test note.', account_id: @account.id, collection_id: collection.id)
    get '/notes'
    expect(last_response.status).to eq(200)
    expect(JSON.parse(last_response.body).size).to eq(1)
  end
end
