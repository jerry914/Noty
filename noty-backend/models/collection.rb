# models/collection.rb
class Collection < Sequel::Model
  plugin :validation_helpers

  many_to_one :account
  one_to_many :notes

  def validate
    super
    validates_presence [:name, :account_id]
  end
end
