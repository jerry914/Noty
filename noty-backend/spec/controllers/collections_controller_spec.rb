# spec/controllers/collections_controller_spec.rb
require_relative '../spec_helper'

RSpec.describe 'Collections Controller' do
  before do
    @account = Account.create(name: 'Test Account', email: 'test@example.com')
    header 'Content-Type', 'application/json'
    env 'rack.session', { account_id: @account.id }
  end

  it 'creates a new collection' do
    post '/collections', { name: 'Test Collection', prompt: 'Test Prompt' }.to_json
    expect(last_response.status).to eq(201)
    expect(JSON.parse(last_response.body)['message']).to eq('Collection created successfully')
  end

  it 'retrieves collections' do
    Collection.create(name: 'Test Collection', prompt: 'Test Prompt', account_id: @account.id)
    get '/collections'
    expect(last_response.status).to eq(200)
    expect(JSON.parse(last_response.body).size).to eq(1)
  end
end
