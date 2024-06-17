import 'package:ada_lovelace/src/presentation/screens/edit_note_page/edit_note_page_scren.dart';
import 'package:ada_lovelace/src/presentation/screens/notes_list_page/notes_list_page_screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const NotesListPageScreen(),
    ),
    GoRoute(
        path: '/add_note',
        builder: (context, state) => const EditNotePageScreen()),
  ],
);
