import 'dart:io';
import 'dart:typed_data';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

typedef Unit8ListCallback = Function(Uint8List data);
typedef DynamicCallback = Function(dynamic data);

final deviceInfo = DeviceInfoPlugin();

@immutable
class Client {
  final String hostName;
  final int port;
  final Unit8ListCallback onData;
  final DynamicCallback onError;

  final Observable<bool> isConnected = Observable(false);
  final Observable<Socket?> socket = Observable(null);

  Client(this.hostName, this.port, this.onData, this.onError);

  static Future<Client?> connect(String hostName, int port,
      Unit8ListCallback onData, DynamicCallback onError) async {
    final model = Client(hostName, port, onData, onError);
    try {
      await model._connect();
      return model;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<void> _connect() async {
    try {
      socket.value = await Socket.connect(hostName, port);

      socket.value!.listen(
        onData,
        onError: onError,
        onDone: () async {
          isConnected.value = false;
        },
      );

      isConnected.value = true;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  void reconnect() => _connect();

  void write(String message) {
    socket.value!.write(message);
  }

  Future<void> disconnect() async {
    if (socket.value == null) return;
    final androidDeviceInfo = await deviceInfo.androidInfo;
    final message =
        "${androidDeviceInfo.brand} ${androidDeviceInfo.device} is disconnected";
    write(message);
    destroy();
  }

  void destroy() {
    socket.value!.destroy();
    socket.value = null;
  }
}
