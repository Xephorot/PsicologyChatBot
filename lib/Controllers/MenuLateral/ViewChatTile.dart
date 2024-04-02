import 'package:chatbot_psicologia/Controllers/Chat/ChatController.dart';
import 'package:flutter/material.dart';

class ViewChatTile extends StatelessWidget {
  final int chatId;

  const ViewChatTile({
    Key? key,
    required this.chatId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.chat),
      title: Text('Chat $chatId'),
      onTap: () => ChatController.instance.viewChat(context, chatId),
    );
  }
}
