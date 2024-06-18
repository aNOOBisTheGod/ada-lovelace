import 'package:ada_lovelace/src/domain/models/note.dart';
import 'package:logger/web.dart';

class NoteEventLogger {
  final logger = Logger(printer: PrettyPrinter());

  void noteAdded(Note note) {
    logger.d("Добавлена заметка: ${note.toJson()}");
  }

  void noteEdited(Note noteBefore, Note noteAfter) {
    logger.d(
        "Заметка изменена: ${noteBefore.toJson()} =>  ${noteAfter.toJson()}");
  }

  void noteDeleted(Note deletedNote) {
    logger.d("Заметка удалена: ${deletedNote.toJson()}");
  }

  void noteDoneStatusChange(bool showDone) {
    logger.d(
        "Режим просмотра заметок изменен на ${showDone ? '"Показывать сделанные"' : '"Не показывать сделанные"'}");
  }
}
