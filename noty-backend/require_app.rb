# frozen_string_literal: true

require_relative 'controllers/app.rb'

def require_app(folders = %w[lib controllers])
  rb_list = Array(folders).flatten.join(',')
  Dir.glob("./{#{rb_list}}/**/*.rb").each do |file|
    require_relative file
  end
end
