part of 'notes_list_page_bloc.dart';

enum NotificationListPageStatus { loading, done, error }

class NotificationListPageState {
  final List<Note> notesList;
  final NotificationListPageStatus status;
  final bool showDone;

  NotificationListPageState(
      {this.notesList = const [],
      this.status = NotificationListPageStatus.loading,
      this.showDone = false});
}
