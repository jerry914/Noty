# serializers/collection_serializer.rb
class CollectionSerializer
  def initialize(collection)
    @collection = collection
  end

  def serialize
    {
      id: @collection.id,
      name: @collection.name,
      prompt: @collection.prompt,
      account_id: @collection.account_id,
      created_at: @collection.created_at,
      updated_at: @collection.updated_at
    }
  end
end
