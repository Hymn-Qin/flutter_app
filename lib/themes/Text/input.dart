import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  void _textFieldChanged(String str) {
    print(str);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30.0),
      child: TextFormField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10.0),
          labelText: "密码",
          labelStyle: TextStyle(color: Colors.blue),
          hintText: "请输入密码",
          prefixIcon: Icon(Icons.lock, color: Colors.blue),
        ),
        onChanged: _textFieldChanged,
        autofocus: false,
      ),
    );
  }
}
