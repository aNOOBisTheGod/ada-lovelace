import 'package:hive_flutter/hive_flutter.dart';
import 'package:simplenotes/core/logger/note_event_logger.dart';
import 'package:simplenotes/src/domain/models/note.dart';

class NotesLocalStorage {
  final box = Hive.box('notesList');
  final revisionBox = Hive.box('revision');

  void incrementRevision() {
    int revision = revisionBox.get('local') ?? 0;
    revisionBox.put('local', revision + 1);
    NoteEventLogger().localRevisionUpdated(revision + 1);
  }

  List<Note> loadNotes() {
    return (box.get('list') ?? [])
        .map<Note>((e) => Note.fromJson(Map<String, dynamic>.from(e)))
        .toList() as List<Note>;
  }

  void saveNotes(List<Note> notesList) {
    box.put('list', notesList.map((e) => e.toJson()).toList());
  }

  void addNote(Note note) {
    final notesList = (box.get('list') ?? []);
    notesList.add(note.toJson());
    box.put('list', notesList);
    incrementRevision();
  }

  void deleteNote(Note note) {
    final notesList = (box.get('list') ?? []);
    notesList.removeWhere((element) => element['id'] == note.id);
    box.put('list', notesList);
    incrementRevision();
  }

  void editNote(Note note) {
    final notesList = (box.get('list') ?? []);
    notesList[(notesList as List).indexWhere((e) => e['id'] == note.id)] =
        note.toJson();
    box.put('list', notesList);
    incrementRevision();
  }
}
