# api/services/chat_service.rb

require 'openai'

class ChatService

  def self.summarize_text(message, api_key)
    client = OpenAI::Client.new(
      access_token: api_key,
      log_errors: true
    )
    response = client.chat(
    parameters: {
        model: 'gpt-3.5-turbo-0125',
        messages: [
            { role: 'assistant', content: 'Summarize whatever user provided within 3~12 words. Do not return any symbol.'},
            { role: 'user', content: message }
        ],
        temperature: 0.7
    })
    response.dig('choices', 0, 'message', 'content')
  end

  def self.stream_response(message, api_key)
    client = OpenAI::Client.new(
      access_token: api_key,
      log_errors: true
    )

    stream = Enumerator.new do |yielder|
      client.chat(
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
end
