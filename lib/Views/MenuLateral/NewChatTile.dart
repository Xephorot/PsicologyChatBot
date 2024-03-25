import 'package:chatbot_psicologia/Controllers/Chat/ChatController.dart';
import 'package:flutter/material.dart';

class NewChatTile extends StatelessWidget {
  const NewChatTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.plus_one),
      title: const Text('Nuevo Chat'),
      onTap: () => ChatController.instance.restartAndSaveChat(context),
    );
  }
}
