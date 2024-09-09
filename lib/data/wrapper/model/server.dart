import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:network_info_plus/network_info_plus.dart';

typedef Unit8ListCallback = Function(Uint8List data);
typedef DynamicCallback = Function(dynamic data);

@immutable
class Server {
  final Unit8ListCallback? onData;
  final DynamicCallback? onError;

  Server(this.onData, this.onError);

  final Observable<ServerSocket?> serverSocket = Observable(null);

  final Observable<bool> running = Observable(false);
  final ObservableList<Socket> sockets = ObservableList();
  final Observable<String?> address = Observable(null);

  Future<void> start() async {
    debugPrint("server started");
    address.value = await NetworkInfo().getWifiIP();
    runZoned(() async {
      serverSocket.value = await ServerSocket.bind(address.value, 8080);
      running.value = true;
      serverSocket.value!.listen(onRequest);
      const message = "Server is listening in port 8080";
      onData!(Uint8List.fromList(message.codeUnits));
    });
  }

  void onRequest(Socket socket) {
    if (!sockets.contains(socket)) {
      sockets.add(socket);
    }
    socket.listen((event) {
      onData!(event);
    });
  }

  Future<void> close() async {
    await serverSocket.value!.close();
    serverSocket.value = null;
    running.value = false;
  }

  Future<void> broadcast(String data) async {
    onData!(Uint8List.fromList(data.codeUnits));
    for (final socket in sockets) {
      socket.write(data);
    }
  }
}
