import 'package:simplenotes/core/logger/note_event_logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/models/note.dart';

part 'notes_list_page_event.dart';
part 'notes_list_page_state.dart';

class NoteListPageBloc extends Bloc<NoteListPageEvent, NoteListPageState> {
  NoteListPageBloc() : super(NoteListPageState()) {
    on<AddNote>((event, emit) => _addNote(event, emit));
    on<EditNote>((event, emit) => _editNote(event, emit));
    on<DeleteNote>((event, emit) => _deleteNote(event, emit));
    on<ChangeShowDoneStatus>((event, emit) => _editShowDone(event, emit));
  }

  void _addNote(AddNote event, Emitter<NoteListPageState> emit) {
    List<Note> tmp = List.from(state.notesList);
    tmp.add(event.note);
    emit(NoteListPageState(
        notesList: tmp, status: state.status, showDone: state.showDone));
    NoteEventLogger().noteAdded(event.note);
  }

  void _editNote(EditNote event, Emitter<NoteListPageState> emit) {
    List<Note> tmp = List.from(state.notesList);
    int noteIndex = tmp.indexWhere((element) => element.id == event.note.id);
    NoteEventLogger().noteEdited(tmp[noteIndex], event.note);
    tmp[noteIndex] = event.note;
    emit(NoteListPageState(
        notesList: tmp, status: state.status, showDone: state.showDone));
  }

  void _deleteNote(DeleteNote event, Emitter<NoteListPageState> emit) {
    List<Note> tmp = List.from(state.notesList);
    tmp.removeWhere((element) => element.id == event.note.id);
    emit(NoteListPageState(
        notesList: tmp, status: state.status, showDone: state.showDone));
    NoteEventLogger().noteDeleted(event.note);
  }

  void _editShowDone(
      ChangeShowDoneStatus event, Emitter<NoteListPageState> emit) {
    NoteEventLogger().noteDoneStatusChange(!state.showDone);

    emit(NoteListPageState(
        notesList: state.notesList,
        status: state.status,
        showDone: !state.showDone));
  }
}
