import 'dart:math';

part 'note_status.dart';

class Note {
  final String id;
  String text;
  bool isDone;
  NoteStatus status;
  DateTime? deadline;
  String? color;
  int createdAt;
  int changedAt;
  String lastUpdatedBy;

  Note(
      {required this.id,
      required this.text,
      required this.isDone,
      required this.status,
      this.deadline,
      this.color,
      required this.createdAt,
      required this.changedAt,
      required this.lastUpdatedBy});

  Map<String, dynamic> toJson() => {
        'id': id,
        'text': text,
        'importance': status.statusName,
        'done': isDone,
        'deadline': deadline?.millisecondsSinceEpoch,
        'color': color,
        'created_at': createdAt,
        'changed_at': changedAt,
        'last_updated_by': lastUpdatedBy
      };

  factory Note.fromJson(Map<String, dynamic> jsonData) => Note(
      id: jsonData['id'],
      text: jsonData['text'],
      status: NoteStatus.fromName(jsonData['importance']),
      isDone: jsonData['done'],
      deadline: jsonData['deadline'] != null
          ? DateTime.fromMillisecondsSinceEpoch(jsonData['deadline'])
          : null,
      color: jsonData['color'],
      createdAt: jsonData['created_at'],
      changedAt: jsonData['changed_at'],
      lastUpdatedBy: jsonData['last_updated_by']);

  factory Note.fromText(String text, String deviceId) => Note(
      id: Random().nextInt(pow(2, 32).toInt()).toString(),
      text: text,
      status: NoteStatus.basic,
      isDone: false,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      changedAt: DateTime.now().millisecondsSinceEpoch,
      lastUpdatedBy: deviceId);
}
