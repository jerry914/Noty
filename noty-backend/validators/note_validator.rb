# validators/note_validator.rb
class NoteValidator
  def initialize(note)
    @note = note
  end

  def valid?
    @note.valid?
  end
end
