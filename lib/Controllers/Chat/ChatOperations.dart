import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:chatbot_psicologia/Models/ChatUserModel.dart';

class ChatOperations {
  Future<void> restartAndSaveChat(BuildContext context, VoidCallback onChatRestarted) async {
    final String chatJson = _saveChatToJSON();
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/saved_chat.json');
    await file.writeAsString(chatJson);
    _restartChat();
    onChatRestarted();
  }

  String _saveChatToJSON() {
    List<Map<String, dynamic>> messagesJson = ChatMessageModel.messages.map((message) => {
      'user': message.user.id,
      'createdAt': message.createdAt.toIso8601String(),
      'text': message.text,
    }).toList();

    return jsonEncode(messagesJson);
  }

  void _restartChat() {
    ChatMessageModel.messages.clear();
    ChatMessageModel.typingUsers.clear();
  }
}
