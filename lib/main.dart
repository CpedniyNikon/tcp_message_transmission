import 'package:flutter/material.dart';
import 'package:flutter_chat/routes/app_pages.dart';
import 'package:flutter_chat/widgets/main_page.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:url_strategy/url_strategy.dart';


void main() {
  setPathUrlStrategy();
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    defaultTransition: Transition.fade,
    home: const MainPage(),
    getPages: AppPages.pages,
  ));
}