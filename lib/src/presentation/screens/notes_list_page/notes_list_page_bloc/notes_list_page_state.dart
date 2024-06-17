part of 'notes_list_page_bloc.dart';

enum NoteListPageStatus { loading, done, error }

class NoteListPageState {
  final List<Note> notesList;
  final NoteListPageStatus status;
  final bool showDone;

  NoteListPageState(
      {this.notesList = const [],
      this.status = NoteListPageStatus.loading,
      this.showDone = false});
}
