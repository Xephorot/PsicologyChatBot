import 'package:chatbot_psicologia/Controllers/Chat/ChatController.dart';
import 'package:flutter/material.dart';

class ViewChatTile extends StatelessWidget {
  final int chatId;

  const ViewChatTile({
    super.key,
    required this.chatId,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.chat),
      title: Text('Chat $chatId'),
      onTap: () => ChatController.instance.viewChat(context, chatId),
    );
  }
}
