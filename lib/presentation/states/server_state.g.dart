// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ServerState on _ServerStateBase, Store {
  late final _$serverAtom =
      Atom(name: '_ServerStateBase.server', context: context);

  @override
  Server? get server {
    _$serverAtom.reportRead();
    return super.server;
  }

  @override
  set server(Server? value) {
    _$serverAtom.reportWrite(value, super.server, () {
      super.server = value;
    });
  }

  late final _$messageHistoryAtom =
      Atom(name: '_ServerStateBase.messageHistory', context: context);

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

  late final _$startServerAsyncAction =
      AsyncAction('_ServerStateBase.startServer', context: context);

  @override
  Future<void> startServer() {
    return _$startServerAsyncAction.run(() => super.startServer());
  }

  late final _$stopServerAsyncAction =
      AsyncAction('_ServerStateBase.stopServer', context: context);

  @override
  Future<void> stopServer() {
    return _$stopServerAsyncAction.run(() => super.stopServer());
  }

  late final _$_ServerStateBaseActionController =
      ActionController(name: '_ServerStateBase', context: context);

  @override
  void onData(Uint8List data) {
    final _$actionInfo = _$_ServerStateBaseActionController.startAction(
        name: '_ServerStateBase.onData');
    try {
      return super.onData(data);
    } finally {
      _$_ServerStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onError(dynamic data) {
    final _$actionInfo = _$_ServerStateBaseActionController.startAction(
        name: '_ServerStateBase.onError');
    try {
      return super.onError(data);
    } finally {
      _$_ServerStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void handleMessage(String message) {
    final _$actionInfo = _$_ServerStateBaseActionController.startAction(
        name: '_ServerStateBase.handleMessage');
    try {
      return super.handleMessage(message);
    } finally {
      _$_ServerStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
server: ${server},
messageHistory: ${messageHistory}
    ''';
  }
}
