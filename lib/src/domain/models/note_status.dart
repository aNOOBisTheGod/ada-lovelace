part of 'note.dart';

enum NoteStatus {
  high,
  low,
  basic;

  String get statusName {
    switch (this) {
      case NoteStatus.high:
        return 'high';
      case NoteStatus.low:
        return 'low';
      case NoteStatus.basic:
        return 'basic';
    }
  }

  factory NoteStatus.fromName(String name) {
    switch (name) {
      case 'high':
        return NoteStatus.high;
      case 'low':
        return NoteStatus.low;
      case _:
        return NoteStatus.basic;
    }
  }
}
