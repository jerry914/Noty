# services/authentication_service.rb
class AuthenticationService
  def initialize(token)
    @token = token
  end

  def authenticate
    account_info = @token.get('https://www.googleapis.com/oauth2/v1/userinfo').parsed
    Account.find_or_create(email: account_info['email']) do |account|
      account.name = account_info['name']
      account.avatar = account_info['picture']
    end
  end
end
