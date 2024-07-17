# frozen_string_literal: true

require_relative 'config/routes.rb'

def require_app(folders = %w[config/initializers lib controllers models services serializers validators helpers])
  rb_list = Array(folders).flatten.join(',')
  Dir.glob("./{#{rb_list}}/**/*.rb").sort.each do |file|
    require_relative file
  end
end

require_app
