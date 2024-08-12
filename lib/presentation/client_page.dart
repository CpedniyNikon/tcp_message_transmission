import 'package:flutter/material.dart';
import 'package:flutter_chat/presentation/states/client_state.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ClientPage extends StatefulWidget {
  const ClientPage({super.key});

  @override
  State<ClientPage> createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  final ClientState controller = GetIt.I<ClientState>();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Observer(
      builder: (_) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Text(
              "client",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(
            color: Colors.black,
            thickness: 1,
          ),
          TextField(
            controller: addressController,
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
              hintText: "write ip address",
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () => {
                      debugPrint("connecting"),
                      controller.connect(addressController.text),
                    },
                    style: ButtonStyle(
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: const BorderSide(color: Colors.red)))),
                    child: const Text("Подключиться"),
                  ),
                  Container(
                    width: 20,
                    height: 20,
                    color: controller.isConnected != false
                        ? Colors.green
                        : Colors.red,
                  )
                ],
              ),
              ElevatedButton(
                onPressed: () => {
                  debugPrint("disconnecting"),
                  controller.disconnect(),
                },
                style: ButtonStyle(
                    shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: const BorderSide(color: Colors.red)))),
                child: const Text("Отключиться"),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          controller.isConnected ==true
              ? Expanded(
                  child: Column(
                    children: [
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
                              controller.sendMessage(messageController.text);
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
                        children: controller.messageHistory
                            .map((e) => Text(e))
                            .toList(),
                      ))
                    ],
                  ),
                )
              : Container(),
        ],
      ),
    ));
  }
}
