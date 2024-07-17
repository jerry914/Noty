# controllers/sessions_controller.rb

class SessionsController < ApplicationController
  route do |r|
    r.get 'google' do
      r.redirect GoogleClient.auth_code.authorize_url(redirect_uri: GOOGLE_REDIRECT_URI, scope: 'email profile', access_type: 'offline')
    end

    r.get 'google/callback' do
      token = GoogleClient.auth_code.get_token(r.params['code'], redirect_uri: GOOGLE_REDIRECT_URI)
      user_info = token.get('https://www.googleapis.com/oauth2/v1/userinfo').parsed
      account = Account.find_or_create(email: user_info['email']) do |acc|
        acc.name = user_info['name']
        acc.avatar = user_info['picture']
      end

      session['account_id'] = account.id

      { message: 'Login successful', account: AccountSerializer.new(account).serialize }
    end
  end
end
