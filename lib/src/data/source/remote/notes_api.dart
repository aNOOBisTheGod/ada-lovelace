import 'package:hive_flutter/hive_flutter.dart';
import 'package:simplenotes/core/secrets/auth_token.dart';
import 'package:simplenotes/src/domain/models/note.dart';
import 'package:dio/dio.dart';

class NotesApi {
  Dio dio = Dio(BaseOptions(baseUrl: 'https://beta.mrdekk.ru/todo/'));
  final String auth = 'Bearer ${AuthToken().token}';
  final box = Hive.box('X-Last-Known-Revision');

  Future<List<Note>> loadNotes() async {
    final response = await dio.get('/list',
        options: Options(headers: {
          'Authorization': auth,
          'accept': 'application/json',
          'X-Last-Known-Revision': box.get('value')
        }));
    box.put('value', response.data['revision']);
    return (response.data['list'] as List)
        .map((e) => Note.fromJson(e))
        .toList();
  }

  Future<void> addNote(Note note) async {
    final response = await dio.post('list',
        data: {'element': note.toJson()},
        options: Options(headers: {
          'Authorization': auth,
          'accept': 'application/json',
          'X-Last-Known-Revision': box.get('value')
        }));
    box.put('value', response.data['revision']);
  }

  Future<void> deleteNote(Note note) async {
    final response = await dio.delete('/list/${note.id}',
        options: Options(headers: {
          'Authorization': auth,
          'accept': 'application/json',
          'X-Last-Known-Revision': box.get('value')
        }));
    box.put('value', response.data['revision']);
  }

  Future<void> editNote(Note note) async {
    final response = await dio.put('/list/${note.id}',
        data: {'element': note.toJson()},
        options: Options(headers: {
          'Authorization': auth,
          'accept': 'application/json',
          'X-Last-Known-Revision': box.get('value')
        }));
    box.put('value', response.data['revision']);
  }
}
