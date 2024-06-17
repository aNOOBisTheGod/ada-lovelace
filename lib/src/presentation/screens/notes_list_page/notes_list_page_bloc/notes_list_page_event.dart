part of 'notes_list_page_bloc.dart';

sealed class NotificationListPageEvent {
  const NotificationListPageEvent();
}

class AddNote extends NotificationListPageEvent {
  final Note note;
  AddNote(this.note);
}

class EditNote extends NotificationListPageEvent {
  final Note note;
  EditNote(this.note);
}

class DeleteNote extends NotificationListPageEvent {
  final Note note;
  DeleteNote(this.note);
}

class ChangeShowDoneStatus extends NotificationListPageEvent {
  ChangeShowDoneStatus();
}
