import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat/data/wrapper/model/server.dart';
import 'package:mobx/mobx.dart';
part 'server_state.g.dart';

class ServerState = _ServerStateBase with _$ServerState;

abstract class _ServerStateBase with Store {
  @observable
  Server? server;

  @observable
  ObservableList<String> messageHistory = ObservableList<String>();

  @action
  Future<void> startServer() async {
    await server!.start();
  }

  @action
  Future<void> stopServer() async {
    await server!.close();
    messageHistory.clear();
  }

  _ServerStateBase() {
    server = Server(onData, onError);
    startServer();
  }

  @action
  void onData(Uint8List data) {
    final receivedData = String.fromCharCodes(data);
    messageHistory.add(receivedData);
  }

  @action
  void onError(dynamic data) {
    debugPrint(data);
  }

  @action
  void handleMessage(String message) {
    server!.broadcast(message);
  }
}
