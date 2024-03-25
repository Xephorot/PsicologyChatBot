import 'package:chatbot_psicologia/Controllers/Chat/ChatManagement.dart';
import 'package:chatbot_psicologia/Controllers/Chat/ChatOperations.dart';
import 'package:flutter/material.dart';

class ChatController {
  static final ChatController instance = ChatController._internal();
  final ChatOperations _chatOperations = ChatOperations();
  final ChatManagement _chatManagement = ChatManagement();

  ChatController._internal();

  Future<void> restartAndSaveChat(BuildContext context) async {
    await _chatOperations.restartAndSaveChat(context);
    Navigator.of(context).pop();
  }

  void startTest(BuildContext context) {
    _chatManagement.startTest(context);
  }

  void viewChat(BuildContext context, int chatId) {
    _chatManagement.viewChat(context, chatId);
  }
}
