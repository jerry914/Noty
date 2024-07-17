# spec/models/account_spec.rb
require_relative '../spec_helper'

RSpec.describe Account do
  it 'is valid with valid attributes' do
    account = Account.new(name: 'Test Account', email: 'test@example.com')
    expect(account).to be_valid
  end

  it 'is not valid without an email' do
    account = Account.new(name: 'Test Account')
    expect(account).not_to be_valid
  end
end
