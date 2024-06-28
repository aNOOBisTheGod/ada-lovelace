import 'package:simplenotes/src/data/source/local/notes_local_storage.dart';
import 'package:simplenotes/src/data/source/remote/notes_api.dart';
import 'package:simplenotes/src/domain/models/note.dart';
import 'package:simplenotes/src/domain/repository/note_repository.dart';

class NoteRepositoryImpl implements NoteRepository {
  @override
  Future<List<Note>> loadNotes() async {
    try {
      final data = await NotesApi().loadNotes();
      NotesLocalStorage().saveNotes(data);
      return data;
    } catch (e) {
      return NotesLocalStorage().loadNotes();
    }
  }

  @override
  Future<void> addNote(Note note) async {
    await NotesApi().addNote(note);
    NotesLocalStorage().addNote(note);
  }

  @override
  Future<void> editNote(Note note) async {
    await NotesApi().editNote(note);
    NotesLocalStorage().editNote(note);
  }

  @override
  Future<void> deleteNote(Note note) async {
    await NotesApi().deleteNote(note);
    NotesLocalStorage().deleteNote(note);
  }
}
