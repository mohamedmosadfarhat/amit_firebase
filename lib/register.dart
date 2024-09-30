import 'dart:io';

import 'package:amit_firebase/custom_textField.dart';
import 'package:amit_firebase/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class Register extends StatefulWidget {
  Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
                "Register",
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
                        .createUserWithEmailAndPassword(
                            email: email!, password: password!);
                    var snackBar = SnackBar(content: Text("register success"));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } catch (e) {
                    var snackBar = SnackBar(content: Text("$e"));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                  ;
                },
                child: Text("Register"),
              ),
              Row(
                children: [
                  Text("if you have an account"),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(Login.id);
                    },
                    child: Text(
                      "login",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
