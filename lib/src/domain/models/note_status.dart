part of 'note.dart';

enum NoteStatus {
  high,
  low,
  basic;

  String get statusName {
    switch (this) {
      case NoteStatus.high:
        return 'important';
      case NoteStatus.low:
        return 'low';
      case NoteStatus.basic:
        return 'basic';
    }
  }

  factory NoteStatus.fromName(String name) {
    switch (name) {
      case 'important':
        return NoteStatus.high;
      case 'low':
        return NoteStatus.low;
      case _:
        return NoteStatus.basic;
    }
  }
}
