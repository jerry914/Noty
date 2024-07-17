# controllers/chats_controller.rb
class ChatController < ApplicationController
  plugin :streaming

  route do |r|
    r.on 'stream' do
      r.is do
        r.post do
          return if authenticate!

          request_data = JSON.parse(r.body.read)

          message = request_data['message'] || 'The content of user input is empty!'

          account = Account.where(id: current_account.id).first

          if account
            unless account[:llms_secret]
              response.status = 403
              { error: 'API key not found' }.to_json
              return
            end
            encrypted_api_key = account[:llms_secret]

            api_key = EncryptionService.decrypt(encrypted_api_key)

            stream do |out|
              ChatService.stream_response(message, api_key).each { |v| out << v }
            end

          else
            response.status = 403
            { error: 'Username not found' }
          end
        end
      end
    end

    r.on 'summarize' do
      r.is do
        r.post do
          return if authenticate!

          request_data = JSON.parse(r.body.read)

          message = request_data['message'] || 'The content of user input is empty!'

          account = Account.where(id: current_account.id).first

          if account
            unless account[:llms_secret]
              response.status = 403
              { error: 'API key not found' }.to_json
              return
            end
            encrypted_api_key = account[:llms_secret]

            api_key = EncryptionService.decrypt(encrypted_api_key)

            summary = ChatService.summarize_text(message, api_key)

            summary
          else
            response.status = 403
            { error: 'Username not found' }
          end
        end
      end
    end
  end
end
