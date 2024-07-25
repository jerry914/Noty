# controllers/accounts_controller.rb
class AccountsController < ApplicationController
  route do |r|
    r.on 'all' do
      r.is do
        r.get do
          return if authenticate!

          Account.all.map { |account| AccountSerializer.new(account).serialize }
        end
      end
    end

    r.is do
      r.get do
        return if authenticate!

        account = Account.first(id: current_account.id)
        AccountSerializer.new(account).serialize
      end

      r.put do
        return if authenticate!

        if current_account
          data = r.params

          if data['llms_secret']
            data['llms_secret'] = EncryptionService.encrypt(data['llms_secret'])
          end

          if current_account.update(data)
            { message: 'Account updated successfully', account: AccountSerializer.new(current_account).serialize }
          else
            response.status = 422
            { error: 'Invalid account data' }
          end
        else
          response.status = 404
          { error: 'Account not found' }
        end
      end
    end

    r.on Integer do |id|
      account = Account[id: id]

      r.is do
        r.get do
          return if authenticate!

          if account
            AccountSerializer.new(account).serialize
          else
            response.status = 404
            { error: 'Account not found' }
          end
        end

        r.put do
          return if authenticate!

          if account
            data = r.params

            if data['llms_secret']
              data['llms_secret'] = EncryptionService.encrypt(data['llms_secret'])
            end

            if account.update(data)
              { message: 'Account updated successfully', account: AccountSerializer.new(account).serialize }
            else
              response.status = 422
              { error: 'Invalid account data' }
            end
          else
            response.status = 404
            { error: 'Account not found' }
          end
        end

        r.delete do
          return if authenticate!

          if account
            account.destroy
            { message: 'Account deleted successfully' }
          else
            response.status = 404
            { error: 'Account not found' }
          end
        end
      end
    end
  end
end
