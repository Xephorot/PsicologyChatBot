import 'package:chatbot_psicologia/Views/ChatPage.dart';
import 'package:chatbot_psicologia/Views/RosenbergTestScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
         '/rosenbergTest': (context) => const RosenbergTestScreen(),
      },
      home: const ChatPage(),
    );
  }
}
