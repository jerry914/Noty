# spec/services/authentication_service_spec.rb
require_relative '../spec_helper'

RSpec.describe AuthenticationService do
  it 'authenticates a account with valid token' do
    token = double('OAuth2::AccessToken', token: 'token', refresh_token: 'refresh_token')
    allow(token).to receive(:get).and_return(double(parsed: { 'email' => 'test@example.com', 'name' => 'Test Account', 'picture' => 'avatar_url' }))
    service = AuthenticationService.new(token)
    account = service.authenticate
    expect(account.email).to eq('test@example.com')
  end
end
