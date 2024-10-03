import 'package:amit_firebase/chatpage.dart';
import 'package:amit_firebase/fbm.dart';
import 'package:amit_firebase/firebase_options.dart';
import 'package:amit_firebase/home_details.dart';
import 'package:amit_firebase/home_page.dart';
import 'package:amit_firebase/login.dart';
import 'package:amit_firebase/notification.dart';
import 'package:amit_firebase/register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Fbm().initMessaging();
  runApp(MyApp());
}

GlobalKey<NavigatorState> NavigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  //const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: NavigatorKey,
      debugShowCheckedModeBanner: false,
      home: Register(),
      routes: {
        Login.id: (context) => Login(),
        HomePage.id: (context) => HomePage(),
        HomeDetails.id: (context) => HomeDetails(),
        Chatpage.id: (context) => Chatpage(),
        Notification1.id: (context) => Notification1()
      },
    );
  }
}
