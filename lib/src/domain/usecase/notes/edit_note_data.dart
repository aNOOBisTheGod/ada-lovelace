import 'package:simplenotes/src/data/note_repository_impl.dart';
import 'package:simplenotes/src/domain/models/note.dart';
import 'package:simplenotes/src/domain/repository/note_repository.dart';

class EditNoteData {
  final NoteRepository _noteRepository = NoteRepositoryImpl();
  Future<void> call(Note note) async {
    final list = _noteRepository.editNote(note);
    return list;
  }
}
