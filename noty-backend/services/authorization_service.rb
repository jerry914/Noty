# services/authorization_service.rb
class AuthorizationService
  def initialize(account, resource)
    @account = account
    @resource = resource
  end

  def authorized?
    @resource.account_id == @account.id
  end
end
