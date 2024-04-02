import 'package:chatbot_psicologia/Controllers/Chat/ChatController.dart';
import 'package:flutter/material.dart';

class StartTestTile extends StatelessWidget {
  const StartTestTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.chat),
      title: const Text('Iniciar Test'),
      onTap: () => ChatController.instance.startTest(context),
    );
  }
}
