import 'package:flutter/material.dart';
import 'package:flutter_chat/presentation/states/server_state.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

class ServerPage extends StatefulWidget {
  const ServerPage({super.key});

  @override
  State<ServerPage> createState() => _ServerPageState();
}

class _ServerPageState extends State<ServerPage> {
  final ServerState controller = GetIt.I<ServerState>();
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(
        builder: (_) => SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Text(
                  "server",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(controller.server!.running == true
                  ? controller.server!.address!
                  : "0.0.0.0"),
              const Divider(
                color: Colors.black,
                thickness: 1,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  controller: messageController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 10),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.green,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: "write message",
                    hintStyle: const TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () => messageController.clear(),
                    icon: const Icon(Icons.clear),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  IconButton(
                    onPressed: () {
                      controller.handleMessage(messageController.text);
                      messageController.clear();
                      setState(() {});
                    },
                    icon: const Icon(Icons.send),
                  ),
                ],
              ),
              const Divider(
                color: Colors.black,
                thickness: 1,
              ),
              Expanded(
                  child: ListView(
                children:
                    controller.messageHistory.map((e) => Text(e)).toList(),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
