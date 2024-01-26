import 'dart:io';
import 'dart:typed_data';

import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';

typedef Unit8ListCallback = Function(Uint8List data);
typedef DynamicCallback = Function(dynamic data);

final deviceInfo = DeviceInfoPlugin();

class ClientModel {
  String hostName;
  int port;
  Unit8ListCallback onData;
  DynamicCallback onError;

  ClientModel(this.hostName, this.port, this.onData, this.onError);

  bool isConnected = false;

  Socket? socket;

  Future<void> connect() async {
    try {
      socket = await Socket.connect(hostName, port);
      socket!.listen(
        onData,
        onError: onError,
        onDone: () async {
          final info = await deviceInfo.androidInfo;
          disconnect(info);
          isConnected = false;
        },
      );
      isConnected = true;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void write(String message) {
    socket!.write(message);
  }

  void disconnect(AndroidDeviceInfo androidDeviceInfo) {
    final message =
        "${androidDeviceInfo.brand} ${androidDeviceInfo.device} is disconnected";
    write(message);
    if (socket != null) {
      socket!.destroy();
    }
  }
}
