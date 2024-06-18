import 'dart:io';

import 'package:ada_lovelace/core/navigation/router.dart';
import 'package:ada_lovelace/src/presentation/screens/edit_note_page/edit_note_page_bloc/edit_note_page_bloc.dart';
import 'package:ada_lovelace/src/presentation/screens/notes_list_page/notes_list_page_bloc/notes_list_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory dir = await getApplicationDocumentsDirectory();

  Hive.init(dir.path);
  runApp(const AdaLovelaceApp());
}

class AdaLovelaceApp extends StatelessWidget {
  const AdaLovelaceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<NoteListPageBloc>(
            create: (context) => NoteListPageBloc(),
          ),
          BlocProvider<EditNotePageBloc>(
            create: (context) => EditNotePageBloc(),
          ),
        ],
        child: MaterialApp.router(
          darkTheme: ThemeData(
            primaryColor: Colors.black,
            brightness: Brightness.dark,
            cardColor: const Color(0xff3C3C3F),
            colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.blue, brightness: Brightness.dark),
            inputDecorationTheme: InputDecorationTheme(
                labelStyle: const TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: const Color(0xff3C3C3F)),
            textTheme: TextTheme(
                bodyMedium: GoogleFonts.roboto(
                    textStyle: const TextStyle(fontSize: 16)),
                bodySmall: GoogleFonts.roboto(
                    textStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w400)),
                titleMedium: GoogleFonts.roboto(
                    textStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.w400)),
                titleLarge: GoogleFonts.roboto(
                    textStyle:
                        const TextStyle(fontSize: 32, color: Colors.white))),
          ),
          routerConfig: router,
          themeMode: ThemeMode.dark,
          theme: ThemeData(
              inputDecorationTheme: InputDecorationTheme(
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.white),
              cardColor: Colors.white,
              primaryColor: const Color(0xffF7F6F2),
              appBarTheme:
                  const AppBarTheme(backgroundColor: Color(0xfff7f6f4)),
              scaffoldBackgroundColor: const Color(0xfff7f6f3),
              textTheme: TextTheme(
                  bodySmall: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.w400)),
                  titleMedium: GoogleFonts.roboto(
                      textStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                          fontWeight: FontWeight.w400)),
                  titleLarge: GoogleFonts.roboto(
                      textStyle: const TextStyle(fontSize: 32)))),
        ));
  }
}
