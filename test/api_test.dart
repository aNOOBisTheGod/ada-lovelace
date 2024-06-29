import 'dart:io';
import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:simplenotes/core/utils/get_device_id.dart';
import 'package:simplenotes/core/utils/http_overrides.dart';
import 'package:simplenotes/src/data/source/remote/notes_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:simplenotes/src/domain/models/note.dart';

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();

  test('Тест добавления заметки', () async {
    String id = await GetDeviceId().getId();
    List<Note> data = await NotesApi().loadNotes();
    int firstresult = data.length;
    Note note =
        Note.fromText(Random().nextInt(pow(2, 32).toInt()).toString(), id);
    await NotesApi().addNote(note);
    data = await NotesApi().loadNotes();
    int secondResult = data.length;
    expect(secondResult - firstresult, 1);
  });
}
