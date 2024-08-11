import 'package:flutter/material.dart';
import 'package:flutter_chat/application/dependencies/routes_module.dart';

class Application extends StatelessWidget {
  const Application({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
    );
  }
}