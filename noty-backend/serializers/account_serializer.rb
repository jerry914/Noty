# serializers/account_serializer.rb
class AccountSerializer
  def initialize(account)
    @account = account
  end

  def serialize
    {
      id: @account.id,
      name: @account.name,
      email: @account.email,
      avatar: @account.avatar,
      exist_llms_secret: @account.llms_secret ? 'yes' : 'no',
      created_at: @account.created_at,
      updated_at: @account.updated_at,
      last_login: @account.last_login
    }
  end
end
