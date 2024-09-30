import 'package:amit_firebase/chatpage.dart';
import 'package:amit_firebase/firebase_options.dart';
import 'package:amit_firebase/home_details.dart';
import 'package:amit_firebase/home_page.dart';
import 'package:amit_firebase/login.dart';
import 'package:amit_firebase/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Register(),
      routes: {
        Login.id: (context) => Login(),
        HomePage.id: (context) => HomePage(),
        HomeDetails.id: (context) => HomeDetails(),
        Chatpage.id:(context)=>Chatpage()
      },
    );
  }
}
