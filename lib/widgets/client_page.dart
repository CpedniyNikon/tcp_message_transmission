import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_chat/utils/client_controller.dart';
import 'package:get/get.dart';

class ClientPage extends StatefulWidget {
  const ClientPage({super.key});

  @override
  State<ClientPage> createState() => _ClientPageState();
}

class _ClientPageState extends State<ClientPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<ClientController>(
      init: ClientController(),
      builder: (controller) {
        return Column(
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
              controller: controller.addressController,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                hintText: "write ip address",
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () => {
                    debugPrint("connecting"),
                    controller.connect(),
                    setState(() {}),
                  },
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: const BorderSide(color: Colors.red)))),
                  child: const Text("Подключиться"),
                ),
                Container(
                  width: 20,
                  height: 20,
                  color: controller.clientModel?.isConnected == true ? Colors.green : Colors.red,
                )
              ],
            ),
            const SizedBox(height: 10,),
            controller.clientModel?.isConnected == true ? Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                      controller: controller.messageController,
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
                        onPressed: () => {controller.messageController.clear()},
                        icon: const Icon(Icons.clear),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      IconButton(
                        onPressed: controller.sendMessage,
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
                        controller.logs.map((e) => Text("$e")).toList(),
                      ))
                ],
              ),
            ) : Container(),
          ],
        );
      },
    ));
  }
}
