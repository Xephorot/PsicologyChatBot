import 'package:chatbot_psicologia/Views/Widgets/Start/WelcomeScreen.dart';
import 'package:flutter/material.dart';

void main() => runApp(const PsicoApp());

class PsicoApp extends StatelessWidget {
  const PsicoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: WelcomeScreen(),
    );
  }
}
