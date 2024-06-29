import 'dart:io';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:simplenotes/core/navigation/router.dart';
import 'package:simplenotes/core/themes/dark_theme.dart';
import 'package:simplenotes/core/themes/light_theme.dart';
import 'package:simplenotes/core/utils/http_overrides.dart';
import 'package:simplenotes/l10n/generated/app_localizations.dart';
import 'package:simplenotes/src/domain/usecase/notes/add_note_data.dart';
import 'package:simplenotes/src/domain/usecase/notes/delete_note_data.dart';
import 'package:simplenotes/src/domain/usecase/notes/edit_note_data.dart';
import 'package:simplenotes/src/domain/usecase/notes/get_notes_list.dart';
import 'package:simplenotes/src/presentation/screens/edit_note_page/edit_note_page_bloc/edit_note_page_bloc.dart';
import 'package:simplenotes/src/presentation/screens/notes_list_page/notes_list_page_bloc/notes_list_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory dir = await getApplicationDocumentsDirectory();
  HttpOverrides.global = MyHttpOverrides();

  Hive.init(dir.path);
  await Hive.openBox('notesList');
  await Hive.openBox('revision');
  runApp(AdaLovelaceApp());
}

class AdaLovelaceApp extends StatelessWidget {
  AdaLovelaceApp({super.key});
  final GetNotesList _getNotesList = GetNotesList();
  final DeleteNoteData _deleteNoteData = DeleteNoteData();
  final EditNoteData _editNoteData = EditNoteData();
  final AddNoteData _addNoteData = AddNoteData();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<NoteListPageBloc>(
            create: (context) => NoteListPageBloc(
                getNotesList: _getNotesList,
                deleteNoteData: _deleteNoteData,
                editNoteData: _editNoteData,
                addNoteData: _addNoteData),
          ),
          BlocProvider<EditNotePageBloc>(
            create: (context) => EditNotePageBloc(),
          ),
        ],
        child: MaterialApp.router(localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ], supportedLocales: const [
          Locale('en'),
          Locale('ru'),
        ], darkTheme: darkTheme, routerConfig: router, theme: lightTheme));
  }
}
