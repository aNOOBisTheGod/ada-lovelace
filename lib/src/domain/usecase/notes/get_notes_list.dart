import 'dart:async';

import 'package:simplenotes/src/data/note_repository_impl.dart';
import 'package:simplenotes/src/domain/models/note.dart';
import 'package:simplenotes/src/domain/repository/note_repository.dart';

class GetNotesList {
  final NoteRepository _noteRepository = NoteRepositoryImpl();
  FutureOr<List<Note>> call() async {
    final list = await _noteRepository.loadNotes();
    return list;
  }
}
