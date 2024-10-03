import 'package:amit_firebase/chatpage.dart';
import 'package:amit_firebase/custom_textField.dart';
import 'package:amit_firebase/home_page.dart';
import 'package:amit_firebase/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);
  static String id = "login";
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? email;

  String? password;
  @override
  void initState() {
    // TODO: implement initState
    FirebaseMessaging.instance.getAPNSToken().then((token) {
      print("+++++++++++++++++++++++++");
      print(token);
      print("+++++++++++++++++++++++++");
    });
    super.initState();
  }
  // void handle(RemoteMessage? messag) {
  //   if (messag != null) {
  //     print("Ahmed farhat");
  //     Navigator.of(context).pushNamed(Notificathoion.id ,arguments:messag );
  //   }
  // }

  //  handle2() async {
  //   await FirebaseMessaging.instance.getInitialMessage().then(handle);
  // }

  // @override
  // void initState() {
  //   print("+++++++++++++++++++++++++++");
  //   var fbm = FirebaseMessaging.instance.getToken().then((v) {
  //     print(v);
  //   });
  //   print("+++++++++++++++++++++++++++");
  //   handle2();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(backgroundColor: Colors.amber,),

      body: Padding(
        padding: const EdgeInsets.only(top: 80.0, left: 20, right: 20),
        child: Center(
          child: Column(
            children: [
              Text(
                "Login",
                style: TextStyle(fontSize: 70),
              ),
              CustomTextField(
                lable: "email",
                onchnged: (data) {
                  setState(() {
                    email = data;
                  });
                },
              ),
              SizedBox(
                height: 30,
              ),
              CustomTextField(
                lable: "password",
                onchnged: (data) {
                  setState(() {
                    password = data;
                  });
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    UserCredential userCredential = await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: email!, password: password!);
                    Navigator.of(context)
                        .pushNamed(Chatpage.id, arguments: email);
                  } catch (e) {
                    var snackBar = SnackBar(content: Text("$e"));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                  ;
                },
                child: Text("Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
