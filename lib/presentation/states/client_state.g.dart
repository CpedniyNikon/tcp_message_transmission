// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ClientState on _ClientStateBase, Store {
  Computed<bool>? _$isConnectedComputed;

  @override
  bool get isConnected =>
      (_$isConnectedComputed ??= Computed<bool>(() => super.isConnected,
              name: '_ClientStateBase.isConnected'))
          .value;

  late final _$clientModelAtom =
      Atom(name: '_ClientStateBase.clientModel', context: context);

  @override
  ObservableFuture<ClientModel?> get clientModel {
    _$clientModelAtom.reportRead();
    return super.clientModel;
  }

  @override
  set clientModel(ObservableFuture<ClientModel?> value) {
    _$clientModelAtom.reportWrite(value, super.clientModel, () {
      super.clientModel = value;
    });
  }

  late final _$messageHistoryAtom =
      Atom(name: '_ClientStateBase.messageHistory', context: context);

  @override
  ObservableList<String> get messageHistory {
    _$messageHistoryAtom.reportRead();
    return super.messageHistory;
  }

  @override
  set messageHistory(ObservableList<String> value) {
    _$messageHistoryAtom.reportWrite(value, super.messageHistory, () {
      super.messageHistory = value;
    });
  }

  late final _$connectAsyncAction =
      AsyncAction('_ClientStateBase.connect', context: context);

  @override
  Future<void> connect(String address) {
    return _$connectAsyncAction.run(() => super.connect(address));
  }

  late final _$disconnectAsyncAction =
      AsyncAction('_ClientStateBase.disconnect', context: context);

  @override
  Future<void> disconnect() {
    return _$disconnectAsyncAction.run(() => super.disconnect());
  }

  late final _$_ClientStateBaseActionController =
      ActionController(name: '_ClientStateBase', context: context);

  @override
  void sendMessage(String message) {
    final _$actionInfo = _$_ClientStateBaseActionController.startAction(
        name: '_ClientStateBase.sendMessage');
    try {
      return super.sendMessage(message);
    } finally {
      _$_ClientStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onData(Uint8List data) {
    final _$actionInfo = _$_ClientStateBaseActionController.startAction(
        name: '_ClientStateBase.onData');
    try {
      return super.onData(data);
    } finally {
      _$_ClientStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onError(dynamic data) {
    final _$actionInfo = _$_ClientStateBaseActionController.startAction(
        name: '_ClientStateBase.onError');
    try {
      return super.onError(data);
    } finally {
      _$_ClientStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
clientModel: ${clientModel},
messageHistory: ${messageHistory},
isConnected: ${isConnected}
    ''';
  }
}
