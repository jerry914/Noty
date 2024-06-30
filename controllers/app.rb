# app.rb

require 'roda'
require_relative '../lib/streaming'

class App < Roda
  plugin :streaming
  plugin :json_parser

  route do |r|
    r.root do
      'Welcome to the OpenAI streaming API!'
    end

    r.on 'stream' do
      r.post do
        message = r.params['message'] || 'The content of user input is empty!'
        stream do |out|
          stream_openai_response(message).each { |v| out << v; sleep(0.1) }
        end
      end
    end
  end
end
