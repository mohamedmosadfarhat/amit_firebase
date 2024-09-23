import 'package:amit_firebase/custom_textField.dart';
import 'package:amit_firebase/home_page.dart';
import 'package:amit_firebase/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
                    Navigator.of(context).pushNamed(HomePage.id);
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
