import 'package:ada_lovelace/src/presentation/screens/add_notification_page/add_notification_page_scren.dart';
import 'package:ada_lovelace/src/presentation/screens/notification_list_page/notification_list_page_screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const NotificationsListPageScreen(),
    ),
    GoRoute(
        path: '/add_note',
        builder: (context, state) => const AddNotificationPageScreen()),
  ],
);
