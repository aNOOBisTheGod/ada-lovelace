import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/models/note.dart';

part 'notification_list_page_event.dart';
part 'notification_list_page_state.dart';

class NotificationListPageBloc
    extends Bloc<NotificationListPageEvent, NotificationListPageState> {
  NotificationListPageBloc() : super(NotificationListPageState()) {
    on<AddNote>((event, emit) => _addNote(event, emit));
    on<EditNote>((event, emit) => _editNote(event, emit));
    on<DeleteNote>((event, emit) => _deleteNote(event, emit));
    on<ChangeShowDoneStatus>((event, emit) => _editShowDone(event, emit));
  }

  void _addNote(AddNote event, Emitter<NotificationListPageState> emit) {
    List<Note> tmp = List.from(state.notesList);
    tmp.add(event.note);
    emit(NotificationListPageState(
        notesList: tmp, status: state.status, showDone: state.showDone));
  }

  void _editNote(EditNote event, Emitter<NotificationListPageState> emit) {
    List<Note> tmp = List.from(state.notesList);
    tmp[tmp.indexWhere((element) => element.id == event.note.id)] = event.note;
    emit(NotificationListPageState(
        notesList: tmp, status: state.status, showDone: state.showDone));
  }

  void _deleteNote(DeleteNote event, Emitter<NotificationListPageState> emit) {
    List<Note> tmp = List.from(state.notesList);
    tmp.removeWhere((element) => element.id == event.note.id);
    emit(NotificationListPageState(
        notesList: tmp, status: state.status, showDone: state.showDone));
  }

  void _editShowDone(
      ChangeShowDoneStatus event, Emitter<NotificationListPageState> emit) {
    emit(NotificationListPageState(
        notesList: state.notesList,
        status: state.status,
        showDone: !state.showDone));
  }
}
