# validators/collection_validator.rb
class CollectionValidator
  def initialize(collection)
    @collection = collection
  end

  def valid?
    @collection.valid?
  end
end
