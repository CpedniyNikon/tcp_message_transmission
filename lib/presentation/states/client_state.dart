import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat/data/client.dart';
import 'package:mobx/mobx.dart';

part 'client_state.g.dart';

class ClientState = _ClientStateBase with _$ClientState;

abstract class _ClientStateBase with Store {
  @observable
  ObservableFuture<ClientModel?> clientModel = ObservableFuture.value(null);

  @observable
  ObservableList<String> messageHistory = ObservableList<String>();

  int port = 8080;

  @action
  Future<void> connect(String address) async {
    clientModel =
        ObservableFuture(ClientModel.connect(address, port, onData, onError));
  }

  @action
  void sendMessage(String message) {
    clientModel.value!.write(message);
    messageHistory.add(message);
  }

  @action
  void onData(Uint8List data) {
    final message = String.fromCharCodes(data);
    messageHistory.add(message);
  }

  @action
  void onError(dynamic data) {
    debugPrint(data);
  }
}
