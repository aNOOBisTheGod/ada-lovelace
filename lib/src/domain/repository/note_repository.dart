import 'package:simplenotes/src/domain/models/note.dart';

abstract class NoteRepository {
  Future<List<Note>> loadNotes();
  Future<void> addNote(Note note);
  Future<void> deleteNote(Note note);
  Future<void> editNote(Note note);
}
