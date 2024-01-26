import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter_chat/utils/server.dart';
import 'package:get/get.dart';

class ServerController extends GetxController {
  Server? server;
  List<String> serverLogs = [];
  TextEditingController controller = TextEditingController();

  Future<void> startServer() async {
    await server!.start();
  }

  Future<void> stopServer() async {
    await server!.close();
    serverLogs.clear();
  }

  @override
  void onInit() {
    server = Server(onData, onError);
    startServer();
    super.onInit();
  }

  void onData(Uint8List data) {
    final receivedData = String.fromCharCodes(data);
    serverLogs.add("Message from client: $receivedData");
    update();
  }

  void onError(dynamic data) {
    debugPrint(data);
  }

  void handleMessage() {
    server!.broadcast(controller.text);
    controller.clear();
    update();
  }
}