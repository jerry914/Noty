# controllers/collections_controller.rb

class CollectionsController < ApplicationController
  route do |r|
    r.is do
      r.get do
        return if authenticate!

        Collection.where(account_id: current_account.id).all.map { |collection| CollectionSerializer.new(collection).serialize }
      end

      r.post do
        return if authenticate!

        data = r.params
        collection = Collection.new(data.merge(account_id: current_account.id))
        if CollectionValidator.new(collection).valid?
          collection.save
          response.status = 201
          { message: 'Collection created successfully', collection: CollectionSerializer.new(collection).serialize }
        else
          response.status = 422
          { error: 'Invalid collection data' }
        end
      end
    end

    r.on Integer do |id|
      collection = Collection[account_id: current_account.id, id: id]

      r.on 'notes' do
        r.get do
          return if authenticate!
  
          notes = Note.where(account_id: current_account.id, status: 'unarchived', collection_id: collection.id).all
          notes.map { |note| NoteSerializer.new(note).serialize }
        end
      end

      r.is do
        r.get do
          return if authenticate!

          if collection
            CollectionSerializer.new(collection).serialize
          else
            response.status = 404
            { error: 'Collection not found' }
          end
        end

        r.put do
          return if authenticate!

          if collection
            data = r.params
            if collection.update(data)
              { message: 'Collection updated successfully', collection: CollectionSerializer.new(collection).serialize }
            else
              response.status = 422
              { error: 'Invalid collection data' }
            end
          else
            response.status = 404
            { error: 'Collection not found' }
          end
        end

        r.delete do
          return if authenticate!

          if collection
            collection.destroy
            { message: 'Collection deleted successfully' }
          else
            response.status = 404
            { error: 'Collection not found' }
          end
        end
      end
    end
  end
end
