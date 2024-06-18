part of 'edit_note_page_bloc.dart';

sealed class EditNotePageEvent {}

class ChangeNoteStatus extends EditNotePageEvent {
  final NoteStatus status;
  ChangeNoteStatus(this.status);
}

class ChangeNoteDate extends EditNotePageEvent {
  final DateTime date;
  ChangeNoteDate(this.date);
}

class SetNoteToEdit extends EditNotePageEvent {
  final Note note;
  SetNoteToEdit(this.note);
}

class ResetEditPageState extends EditNotePageEvent {
  ResetEditPageState();
}
