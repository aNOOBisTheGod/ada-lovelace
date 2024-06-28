import 'package:simplenotes/core/logger/note_event_logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simplenotes/src/domain/usecase/notes/add_note_data.dart';
import 'package:simplenotes/src/domain/usecase/notes/edit_note_data.dart';
import 'package:simplenotes/src/domain/usecase/notes/get_notes_list.dart';
import '../../../../domain/models/note.dart';
import '../../../../domain/usecase/notes/delete_note_data.dart';

part 'notes_list_page_event.dart';
part 'notes_list_page_state.dart';

class NoteListPageBloc extends Bloc<NoteListPageEvent, NoteListPageState> {
  final GetNotesList _getNotesList;
  final DeleteNoteData _deleteNoteData;
  final EditNoteData _editNoteData;
  final AddNoteData _addNoteData;
  NoteListPageBloc(
      {required GetNotesList getNotesList,
      required DeleteNoteData deleteNoteData,
      required EditNoteData editNoteData,
      required AddNoteData addNoteData})
      : _getNotesList = getNotesList,
        _deleteNoteData = deleteNoteData,
        _addNoteData = addNoteData,
        _editNoteData = editNoteData,
        super(NoteListPageState()) {
    on<AddNote>((event, emit) => _addNote(event, emit));
    on<EditNote>((event, emit) => _editNote(event, emit));
    on<DeleteNote>((event, emit) => _deleteNote(event, emit));
    on<ChangeShowDoneStatus>((event, emit) => _editShowDone(event, emit));
    on<LoadNotes>((event, emit) => _loadNotes(event, emit));
  }

  void _loadNotes(LoadNotes event, Emitter<NoteListPageState> emit) async {
    try {
      final list = await _getNotesList();
      emit(NoteListPageState(
          notesList: list,
          status: NoteListPageStatus.done,
          showDone: state.showDone));
    } catch (_) {
      emit(NoteListPageState(
          notesList: state.notesList,
          status: NoteListPageStatus.error,
          showDone: state.showDone));
    }
  }

  void _addNote(AddNote event, Emitter<NoteListPageState> emit) {
    List<Note> tmp = List.from(state.notesList);
    tmp.add(event.note);
    emit(NoteListPageState(
        notesList: tmp, status: state.status, showDone: state.showDone));
    _addNoteData(event.note);
    NoteEventLogger().noteAdded(event.note);
  }

  void _editNote(EditNote event, Emitter<NoteListPageState> emit) {
    List<Note> tmp = List.from(state.notesList);
    int noteIndex = tmp.indexWhere((element) => element.id == event.note.id);
    tmp[noteIndex] = event.note;
    emit(NoteListPageState(
        notesList: tmp, status: state.status, showDone: state.showDone));
    _editNoteData(event.note);
    NoteEventLogger().noteEdited(tmp[noteIndex], event.note);
  }

  void _deleteNote(DeleteNote event, Emitter<NoteListPageState> emit) {
    List<Note> tmp = List.from(state.notesList);
    tmp.removeWhere((element) => element.id == event.note.id);
    emit(NoteListPageState(
        notesList: tmp, status: state.status, showDone: state.showDone));
    _deleteNoteData(event.note);
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
