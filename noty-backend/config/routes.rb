# config/routes.rb

require 'roda'
require 'sequel'
require 'dotenv/load'

class App < Roda
  plugin :json
  plugin :json_parser
  plugin :sessions, secret: ENV['SESSION_SECRET']
  plugin :flash

  route do |r|
    r.root do
      { message: 'Welcome to Noty API' }
    end

    r.on 'auth' do
      r.run SessionsController
    end

    r.on 'chat' do
      r.run ChatController
    end

    r.on 'notes' do
      r.run NotesController
    end

    r.on 'collections' do
      r.run CollectionsController
    end

    r.on 'accounts' do
      r.run AccountsController
    end
  end
end
