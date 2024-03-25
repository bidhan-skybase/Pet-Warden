import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        height: 100,
        width: 100,
        color: Colors.red,
        child: Text("Error Screen"),
      ),
    );
  }
}
