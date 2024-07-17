# models/account.rb
class Account < Sequel::Model
  plugin :validation_helpers

  one_to_many :notes
  one_to_many :collections

  def validate
    super
    validates_presence [:name, :email]
    validates_unique :email
  end
end
