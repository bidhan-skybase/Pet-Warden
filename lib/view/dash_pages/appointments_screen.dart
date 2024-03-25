import 'package:flutter/material.dart';

class AppointmentScreen extends StatelessWidget {
  const AppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Container(
          height: 100,
          width: 100,
          color: Colors.black,
          child: Text("appointment screen"),
        ),
      ),
    );
  }
}
