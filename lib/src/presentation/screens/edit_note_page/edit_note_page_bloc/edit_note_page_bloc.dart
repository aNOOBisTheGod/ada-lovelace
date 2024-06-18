import 'package:ada_lovelace/src/domain/models/note.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'edit_note_page_event.dart';
part 'edit_note_page_state.dart';

class EditNotePageBloc extends Bloc<EditNotePageEvent, EditNotePageState> {
  EditNotePageBloc() : super(EditNotePageState()) {
    on<ChangeNoteStatus>((event, emit) => _changeNoteStatus(event, emit));
    on<ChangeNoteDate>((event, emit) => _changeNoteDate(event, emit));
    on<SetNoteToEdit>((event, emit) => _setNoteToEdit(event, emit));
    on<ResetEditPageState>((event, emit) => _resetEditPageState(event, emit));
  }

  void _changeNoteStatus(
      ChangeNoteStatus event, Emitter<EditNotePageState> emit) {
    emit(EditNotePageState(noteStatus: event.status, noteDate: state.noteDate));
  }

  void _changeNoteDate(ChangeNoteDate event, Emitter<EditNotePageState> emit) {
    emit(EditNotePageState(noteStatus: state.noteStatus, noteDate: event.date));
  }

  void _setNoteToEdit(SetNoteToEdit event, Emitter<EditNotePageState> emit) {
    emit(EditNotePageState(
        noteDate: event.note.date, noteStatus: event.note.status));
  }

  void _resetEditPageState(_, Emitter<EditNotePageState> emit) {
    emit(EditNotePageState());
  }
}
