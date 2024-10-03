import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class Notification1 extends StatelessWidget {
  const Notification1({Key? key}) : super(key: key);
  static String id = "Notification1";
  @override
  Widget build(BuildContext context) {
    RemoteMessage? message =
        ModalRoute.of(context)!.settings.arguments as RemoteMessage?;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 175, 153, 89),
        title: Text("Notificatio"),
      ),
      body: Container(
        child: Text("${message?.notification?.title}"),
      ),
    );
  }
}
