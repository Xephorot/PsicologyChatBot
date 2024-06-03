import 'package:flutter/material.dart';

class WelcomeMessage extends StatelessWidget {
  const WelcomeMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Bienvenido',
      style: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.w500,
        color: Colors.green[700],
      ),
      textAlign: TextAlign.center,
    );
  }
}
