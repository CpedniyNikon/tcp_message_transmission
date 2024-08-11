import 'package:flutter_chat/presentation/client_page.dart';
import 'package:flutter_chat/presentation/main_page.dart';
import 'package:flutter_chat/presentation/server_page.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MainPage(),
    ),
    GoRoute(
      path: '/client',
      builder: (context, state) => const ClientPage(),
    ),
    GoRoute(
      path: '/server',
      builder: (context, state) => const ServerPage(),
    ),
  ],
);
