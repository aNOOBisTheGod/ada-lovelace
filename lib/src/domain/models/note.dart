part 'note_status.dart';

class Note {
  final int id;
  String title;
  bool isDone;
  NoteStatus status;
  DateTime? date;

  Note(
      {required this.id,
      required this.title,
      required this.isDone,
      required this.status,
      this.date});

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "statusIndex": status.index,
        "isDone": isDone,
        "date": date
      };

  factory Note.fromJson(Map<String, dynamic> jsonData) => Note(
      id: jsonData["id"],
      title: jsonData["title"],
      status: NoteStatus.values[jsonData["statusIndex"]],
      isDone: jsonData['isDone'],
      date: jsonData['date']);
}
