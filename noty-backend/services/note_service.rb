# services/note_service.rb
class NoteService
  def initialize(account, note)
    @account = account
    @note = note
  end

  def create_note
    @note['status'] = 'unarchived'
    unless @note['collection_id']
      @note['collection_id'] = Collection.first(account_id: @account.id).id
    end
    Note.new(@note.merge(account_id: @account.id))
  end
end
