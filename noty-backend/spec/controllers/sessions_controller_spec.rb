# spec/controllers/sessions_controller_spec.rb
require_relative '../spec_helper'

RSpec.describe 'Sessions Controller' do
  it 'redirects to Google for authentication' do
    get '/auth/google'
    expect(last_response).to be_redirect
  end
end
