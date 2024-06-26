import 'package:chatbot_psicologia/Controllers/Chat/ChatOperations.dart';
import 'package:chatbot_psicologia/Views/ChatPage.dart';
import 'package:flutter/material.dart';

class ChatController {
  static final ChatController instance = ChatController._internal();
  final ChatOperations _chatOperations = ChatOperations();

  ChatController._internal();

  Future<void> restartAndSaveChat(BuildContext context) async {
    await _chatOperations.restartAndSaveChat(context, () => _restartUI(context));
  }

  void _restartUI(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const ChatPage()),
      (Route<dynamic> route) => false,
    );
  }
}