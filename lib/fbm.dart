import 'package:amit_firebase/main.dart';
import 'package:amit_firebase/notification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class Fbm {
  final firebaseMsg = FirebaseMessaging.instance;
  initMessaging() async {
    firebaseMsg.requestPermission();
    await firebaseMsg.getToken().then((token) {
      print("+++++++++++++++++++++++++");
      print(token);
      print("+++++++++++++++++++++++++");
    });
    onBakMsg();
  }

  handleMsg(RemoteMessage? message) {
    if (message == null) return;

    NavigatorKey.currentState!.pushNamed(Notification1.id, arguments: message);
  }

  onBakMsg() {
    FirebaseMessaging.instance.getInitialMessage().then(handleMsg);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMsg);
  }
}
