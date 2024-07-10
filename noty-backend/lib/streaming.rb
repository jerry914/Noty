# lib/streaming.rb

require 'openai'

def configure_openai_client
  OpenAI.configure do |config|
    config.access_token = ENV.fetch('OPENAI_API_KEY')
    config.log_errors = true
  end
end

def chat_openai(message)
  client = OpenAI::Client.new
  response = client.chat(
    parameters: {
      model: 'gpt-4o',
      messages: [{ role: 'user', content: message }],
      temperature: 0.7
    }
  )
  response.dig('choices', 0, 'message', 'content')
end

def stream_openai_response(message)
  openai = OpenAI::Client.new
  stream = Enumerator.new do |yielder|
    openai.chat(
      parameters: {
        model: 'gpt-4o',
        messages: [
          { role: 'assistant', content: 'Provide concise answer, within 100 words.' },
          { role: 'user', content: message }
        ],
        temperature: 0.7,
        stream: proc do |chunk, _bytesize|
          content = chunk.dig('choices', 0, 'delta', 'content')
          yielder << content if content
        end
      }
    )
  end
  stream
end

configure_openai_client
