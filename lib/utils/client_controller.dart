import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter_chat/utils/client.dart';
import 'package:get/get.dart';
import 'package:ping_discover_network_v2/ping_discover_network_v2.dart';

class ClientController extends GetxController {
  ClientModel? clientModel;
  List<String> logs = [];
  int port = 8080;
  Stream<NetworkAddress>? stream;
  TextEditingController addressController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  Future<void> connect() async {
    debugPrint(addressController.text);
    if(clientModel == null || clientModel?.isConnected == false) clientModel = ClientModel(addressController.text, port, onData, onError);
    if (clientModel?.isConnected == false) {
      clientModel!.connect();
      update();
    }
  }

  void sendMessage() {
    clientModel!.write(messageController.text);
    logs.add("Message from client: ${messageController.text}");
    messageController.clear();
    update();
  }

  void onData(Uint8List data) {
    final message = String.fromCharCodes(data);
    logs.add("Message from server: ${message}");
    update();
  }

  void onError(dynamic data) {
    debugPrint(data);
  }
}
