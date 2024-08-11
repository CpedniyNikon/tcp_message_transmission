import 'dart:io';
import 'dart:typed_data';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

typedef Unit8ListCallback = Function(Uint8List data);
typedef DynamicCallback = Function(dynamic data);

final deviceInfo = DeviceInfoPlugin();

class ClientModel {
  String hostName;
  int port;
  Unit8ListCallback onData;
  DynamicCallback onError;

  bool isConnected = false;
  Socket? socket;

  ClientModel(this.hostName, this.port, this.onData, this.onError);

  static Future<ClientModel?> connect(String hostName, int port,
      Unit8ListCallback onData, DynamicCallback onError) async {
    final model = ClientModel(hostName, port, onData, onError);
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
      rethrow;
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
