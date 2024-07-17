# config.ru
require 'roda'
require 'sequel'
require 'dotenv'
require 'rack'

Dotenv.load

ENV['RACK_ENV'] ||= 'development'

DB = case ENV['RACK_ENV']
when 'development'
  Sequel.connect(ENV['DATABASE_URL_DEV'])
when 'test'
  Sequel.connect(ENV['DATABASE_URL_TEST'])
else
  Sequel.connect(ENV['DATABASE_URL_PROD'])
end

require_relative 'require_app'

run App.freeze.app
