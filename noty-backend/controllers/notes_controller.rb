# controllers/notes_controller.rb
class NotesController < ApplicationController
  route do |r|
    r.on 'unarchived' do
      r.get do
        return if authenticate!

        notes = Note.where(account_id: current_account.id, status: 'unarchived').all
        notes.map { |note| NoteSerializer.new(note).serialize }
      end
    end

    r.on 'archived' do
      r.get do
        return if authenticate!

        notes = Note.where(account_id: current_account.id, status: 'archived').all
        notes.map { |note| NoteSerializer.new(note).serialize }
      end
    end

    r.is do
      r.get do
        return if authenticate!

        Note.where(account_id: current_account.id).all.map { |note| NoteSerializer.new(note).serialize }
      end

      r.post do
        return if authenticate!
        data = r.params

        note = NoteService.new(current_account, data).create_note
        if NoteValidator.new(note).valid?
          note.save
          response.status = 201
          { message: 'Note created successfully', note: NoteSerializer.new(note).serialize }
        else
          response.status = 422
          { error: 'Invalid note data' }
        end
      end
    end

    r.on Integer do |id|
      note = Note[account_id: current_account.id, id: id]

      r.is do
        r.get do
          return if authenticate!

          if note
            NoteSerializer.new(note).serialize
          else
            response.status = 404
            { error: 'Note not found' }
          end
        end

        r.put do
          return if authenticate!

          if note
            data = r.params
            if note.update(data)
              { message: 'Note updated successfully', note: NoteSerializer.new(note).serialize }
            else
              response.status = 422
              { error: 'Invalid note data' }
            end
          else
            response.status = 404
            { error: 'Note not found' }
          end
        end

        r.delete do
          return if authenticate!

          if note
            note.destroy
            { message: 'Note deleted successfully' }
          else
            response.status = 404
            { error: 'Note not found' }
          end
        end
      end
    end
  end
end
