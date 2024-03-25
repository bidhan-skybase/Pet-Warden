import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Container(
          height: 100,
          width: 100,
          color: Colors.red,
          child: Text("Chat Screen"),
        ),
      ),
    );
  }
}
