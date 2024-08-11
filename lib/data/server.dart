import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:network_info_plus/network_info_plus.dart';

typedef Unit8ListCallback = Function(Uint8List data);
typedef DynamicCallback = Function(dynamic data);

class Server {
  Unit8ListCallback? onData;
  DynamicCallback? onError;
  Server(this.onData, this.onError);

  ServerSocket? serverSocket;

  bool running = false;
  List<Socket> sockets = [];
  String? address;

  Future<void> start() async {
    debugPrint("server started");
    address = await NetworkInfo().getWifiIP();
    runZoned(() async {
      serverSocket = await ServerSocket.bind(address, 8080);
      running = true;
      serverSocket!.listen(onRequest);
      const message = "Server is listening in port 8080";
      onData!(Uint8List.fromList(message.codeUnits));
    });
  }

  void onRequest(Socket socket) {
    if (!sockets.contains(socket)) {
      sockets.add(socket);
    }
    socket.listen((event) {onData!(event);});
  }

  Future<void> close() async {
    await serverSocket!.close();
    serverSocket = null;
    running = false;
  }

  void broadcast(String data) {
    onData!(Uint8List.fromList("Message from server: $data".codeUnits));
    for(final socket in sockets) {
      socket.write(data);
    }
  }
}
