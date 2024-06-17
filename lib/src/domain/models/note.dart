part 'note_status.dart';

class Note {
  final int id;
  String title;
  String description;
  bool isDone;
  NoteStatus status;

  Note(
      {required this.id,
      required this.title,
      required this.description,
      required this.isDone,
      required this.status});

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "statusIndex": status.index,
        "isDone": isDone
      };

  factory Note.fromJson(Map<String, dynamic> jsonData) => Note(
      id: jsonData["id"],
      title: jsonData["title"],
      description: jsonData["description"],
      status: NoteStatus.values[jsonData["statusIndex"]],
      isDone: jsonData['isDone']);
}
