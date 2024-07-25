# services/collection_service.rb

class CollectionService
  def initialize(account)
    @account = account
  end

  def create_default
    data = { 'name': 'One shot', 'prompt': 'Provide concise answer, within 100 words.' }
    collection = Collection.new(data.merge(account_id: @account.id))
    collection.save if CollectionValidator.new(collection).valid?
  end
end
