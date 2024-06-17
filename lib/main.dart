import 'dart:io';

import 'package:ada_lovelace/src/presentation/navigation/router.dart';
import 'package:ada_lovelace/src/presentation/screens/notification_list_page/notification_list_page_bloc/notification_list_page_bloc.dart';
import 'package:ada_lovelace/src/presentation/screens/notification_list_page/notification_list_page_screen.dart';
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
          BlocProvider<NotificationListPageBloc>(
            create: (context) => NotificationListPageBloc(),
          ),
        ],
        child: MaterialApp.router(
          routerConfig: router,
          theme: ThemeData(
              scaffoldBackgroundColor: const Color(0xfff7f6f3),
              textTheme: TextTheme(
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
