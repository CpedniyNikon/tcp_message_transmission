import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:flutter_chat/routes/routes.dart';
import 'package:flutter_chat/widgets/client_page.dart';
import 'package:flutter_chat/widgets/main_page.dart';
import 'package:flutter_chat/widgets/server_page.dart';


abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.main,
      page: () => const MainPage(),
    ),GetPage(
      name: Routes.client,
      page: () => const ClientPage(),
    ),GetPage(
      name: Routes.server,
      page: () => const ServerPage(),
    ),
  ];
}