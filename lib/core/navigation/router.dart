import 'package:simplenotes/src/domain/models/note.dart';
import 'package:simplenotes/src/presentation/screens/edit_note_page/edit_note_page_scren.dart';
import 'package:simplenotes/src/presentation/screens/notes_list_page/notes_list_page_screen.dart';
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
        builder: (context, state) {
          Note? note = state.extra as Note?;
          return EditNotePageScreen(
            noteToEdit: note,
          );
        }),
  ],
);
