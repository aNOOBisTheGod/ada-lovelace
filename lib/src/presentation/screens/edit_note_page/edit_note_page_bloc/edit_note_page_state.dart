part of 'edit_note_page_bloc.dart';

class EditNotePageState {
  final NoteStatus noteStatus;
  DateTime? noteDate;
  EditNotePageState({this.noteStatus = NoteStatus.basic, this.noteDate});
}
