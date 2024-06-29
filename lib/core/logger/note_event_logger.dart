import 'package:simplenotes/src/domain/models/note.dart';
import 'package:logger/web.dart';

class NoteEventLogger {
  final logger = Logger(printer: PrettyPrinter());

  void noteAdded(Note note) {
    logger.d('Добавлена заметка: ${note.toJson()}');
  }

  void noteEdited(Note noteBefore, Note noteAfter) {
    logger.d(
        'Заметка изменена: ${noteBefore.toJson()} =>  ${noteAfter.toJson()}');
  }

  void noteDeleted(Note deletedNote) {
    logger.d('Заметка удалена: ${deletedNote.toJson()}');
  }

  void noteDoneStatusChange(bool showDone) {
    logger.d(
        "Режим просмотра заметок изменен на ${showDone ? '"Показывать сделанные"' : '"Не показывать сделанные"'}");
  }

  void localRevisionUpdated(int currentRevision) {
    logger.d('Локальная ревизия списка обновлена: $currentRevision');
  }

  void remoteRevisionUpdated(int currentRevision) {
    logger.d('Облачная ревизия списка обновлена: $currentRevision');
  }

  void remoteNotesListLoaded() {
    logger.d('Загружен список заметок с сервера');
  }

  void localNotesListLoaded() {
    logger.d(
        'Произошла ошибка при загрузке данных с сервера. Загружен локальный список заметок');
  }

  void remoteNoteAdded(Note note) {
    logger.d('На сервер загружена заметка: ${note.toJson()}');
  }

  void remoteNoteEdited(Note note) {
    logger.d('Заметка изменена на сервере: ${note.toJson()}');
  }

  void remoteNoteDeleted(Note deletedNote) {
    logger.d('Заметка удалена с сервера: ${deletedNote.toJson()}');
  }

  void remoteNotesListPatched() {
    logger.d('Локальный и удаленный списки заметок синхронизированы');
  }
}
