import 'package:hive_flutter/hive_flutter.dart';
import 'package:simplenotes/core/logger/note_event_logger.dart';
import 'package:simplenotes/src/data/source/local/notes_local_storage.dart';
import 'package:simplenotes/src/data/source/remote/notes_api.dart';
import 'package:simplenotes/src/domain/models/note.dart';
import 'package:simplenotes/src/domain/repository/note_repository.dart';

class NoteRepositoryImpl implements NoteRepository {
  Future<void> updateRemoteNotesList() async {
    final box = Hive.box('revision');
    if ((box.get('remote') ?? 0) < (box.get('local') ?? 0)) {
      await NotesApi().patchNotesList(NotesLocalStorage().loadNotes());
    }
  }

  @override
  Future<List<Note>> loadNotes() async {
    try {
      final data = await NotesApi().loadNotes();
      NotesLocalStorage().saveNotes(data);
      NoteEventLogger().remoteNotesListLoaded();
      return data;
    } catch (e) {
      NoteEventLogger().localNotesListLoaded();
      return NotesLocalStorage().loadNotes();
    }
  }

  @override
  Future<void> addNote(Note note) async {
    NotesLocalStorage().addNote(note);
    await NotesApi().addNote(note);
    updateRemoteNotesList();
  }

  @override
  Future<void> editNote(Note note) async {
    NotesLocalStorage().editNote(note);
    await NotesApi().editNote(note);
    updateRemoteNotesList();
  }

  @override
  Future<void> deleteNote(Note note) async {
    NotesLocalStorage().deleteNote(note);
    await NotesApi().deleteNote(note);
    updateRemoteNotesList();
  }
}
