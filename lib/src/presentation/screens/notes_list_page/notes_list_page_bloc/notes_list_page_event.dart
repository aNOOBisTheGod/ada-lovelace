part of 'notes_list_page_bloc.dart';

sealed class NoteListPageEvent {
  const NoteListPageEvent();
}

class AddNote extends NoteListPageEvent {
  final Note note;
  AddNote(this.note);
}

class EditNote extends NoteListPageEvent {
  final Note note;
  EditNote(this.note);
}

class DeleteNote extends NoteListPageEvent {
  final Note note;
  DeleteNote(this.note);
}

class ChangeShowDoneStatus extends NoteListPageEvent {
  ChangeShowDoneStatus();
}

class LoadNotes extends NoteListPageEvent {
  LoadNotes();
}
