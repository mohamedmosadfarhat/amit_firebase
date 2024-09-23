import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({required this.lable,required this.onchnged});
  String lable;
  Function(String) onchnged;
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onchnged,
      decoration: InputDecoration(label: Text("$lable")),
    );
  }
}
