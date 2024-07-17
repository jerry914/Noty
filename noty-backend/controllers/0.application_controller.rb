# controllers/application_controller.rb
require 'rack/cors'

class ApplicationController < Roda
  plugin :json
  plugin :json_parser
  plugin :all_verbs
  plugin :sessions, secret: ENV['SESSION_SECRET']
  plugin :flash

  use Rack::Cors do
    allow do
      origins 'http://localhost:5173' # Replace with your frontend domain
      resource '*',
               headers: :any,
               methods: %i[get post put patch delete options head],
               credentials: true
    end
  end

  def current_account
    @current_account ||= Account[session['account_id']] if session['account_id']
  end

  def authenticate!
    return if current_account

    response.status = 401
    { error: 'Unauthorized' }
  end
end
