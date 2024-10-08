import 'package:flutter_chat/domain/state/client/client_state.dart';
import 'package:flutter_chat/domain/state/server/server_state.dart';
import 'package:get_it/get_it.dart';

void setup() {
  GetIt.I.registerLazySingleton<ServerState>(() => ServerState());
  GetIt.I.registerSingleton<ClientState>(ClientState());
}
