# spec/spec_helper.rb
require 'roda'
require 'rack/test'
require 'rspec'
require 'sequel'
require 'dotenv/load'

ENV['RACK_ENV'] ||= 'test'

DB = Sequel.connect(ENV['DATABASE_URL_TEST'])

require_relative '../require_app'

RSpec.configure do |config|
  config.include Rack::Test::Methods

  def app
    App.freeze.app
  end

  config.before(:suite) do
    Sequel.extension :migration
    Sequel::Migrator.run(DB, 'db/migrations')
    DB[:notes].truncate
    DB[:collections].truncate
    DB[:accounts].truncate
  end

  config.after(:each) do
    DB[:notes].truncate
    DB[:collections].truncate
    DB[:accounts].truncate
  end
end
