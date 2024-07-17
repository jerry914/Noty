# serializers/note_serializer.rb
class NoteSerializer
  def initialize(note)
    @note = note
  end

  def serialize
    {
      id: @note.id,
      title: @note.title,
      content: @note.content,
      status: @note.status,
      collection_id: @note.collection_id,
      account_id: @note.account_id,
      created_at: @note.created_at,
      updated_at: @note.updated_at
    }
  end
end
