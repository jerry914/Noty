# config/initializers/google_oauth.rb
require 'oauth2'

GOOGLE_CLIENT_ID = ENV['GOOGLE_CLIENT_ID']
GOOGLE_CLIENT_SECRET = ENV['GOOGLE_CLIENT_SECRET']
GOOGLE_REDIRECT_URI = ENV['GOOGLE_REDIRECT_URI']
API_DOMAIN_URL = ENV['API_DOMAIN_URL']

GoogleClient = OAuth2::Client.new(
  GOOGLE_CLIENT_ID,
  GOOGLE_CLIENT_SECRET,
  site: 'https://accounts.google.com',
  authorize_url: '/o/oauth2/auth',
  token_url: '/o/oauth2/token'
)
