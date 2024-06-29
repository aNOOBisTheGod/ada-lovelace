import 'dart:async';

import 'package:simplenotes/src/data/note_repository_impl.dart';
import 'package:simplenotes/src/domain/repository/note_repository.dart';

import '../../models/note.dart';

class DeleteNoteData {
  final NoteRepository _noteRepository = NoteRepositoryImpl();
  Future<void> call(Note note) async {
    final list = _noteRepository.deleteNote(note);
    return list;
  }
}
