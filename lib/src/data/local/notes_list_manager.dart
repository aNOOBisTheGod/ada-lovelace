import 'package:ada_lovelace/src/domain/models/note.dart';
import 'package:hive/hive.dart';

class NotesListManager {
  var box = Hive.box("notesList");

  void saveList(List<Note> notesList) {
    List<Map> notesListJson = notesList.map((e) => e.toJson()).toList();
    box.put('notes_list', notesListJson);
  }

  List<Note> loadData() {
    List<Map<String, dynamic>> notesData = box.get('notes_list') ?? [];
    return notesData.map((e) => Note.fromJson(e)).toList();
  }
}
