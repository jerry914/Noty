# models/note.rb
class Note < Sequel::Model
  plugin :validation_helpers

  many_to_one :account
  many_to_one :collection

  def validate
    super
    validates_presence [:title, :content, :account_id, :collection_id]
  end
end
