import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat/data/wrapper/model/client.dart';
import 'package:mobx/mobx.dart';

part 'client_state.g.dart';

class ClientState = _ClientStateBase with _$ClientState;

abstract class _ClientStateBase with Store {
  @observable
  ObservableFuture<Client?> clientModel = ObservableFuture.value(null);

  @observable
  ObservableList<String> messageHistory = ObservableList<String>();

  int port = 8080;

  @action
  Future<void> connect(String address) async {
    if (clientModel.value == null) {
      clientModel =
          ObservableFuture(Client.connect(address, port, onData, onError));
    } else if (clientModel.value!.isConnected.value == false) {
      clientModel.value!.reconnect();
    }
  }

  @computed
  bool get isConnected => clientModel.value?.isConnected.value == true;

  @action
  Future<void> disconnect() async {
    await clientModel.value!.disconnect();
    messageHistory.clear();
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
