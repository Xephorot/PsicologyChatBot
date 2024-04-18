import 'package:chatbot_psicologia/Controllers/Chat/ChatManagement.dart';
import 'package:chatbot_psicologia/Controllers/Chat/ChatOperations.dart';
import 'package:chatbot_psicologia/Views/ChatPage.dart';
import 'package:flutter/material.dart';

class ChatController {
  static final ChatController instance = ChatController._internal();
  final ChatOperations _chatOperations = ChatOperations();
  final ChatManagement _chatManagement = ChatManagement();

  ChatController._internal();

  // Método para reiniciar y guardar el chat
  Future<void> restartAndSaveChat(BuildContext context) async {
    await _chatOperations.restartAndSaveChat(context, () => _restartUI(context));
  }

  // Método privado para reiniciar la interfaz de usuario
  void _restartUI(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const ChatPage()),
      (Route<dynamic> route) => false,
    );
  }

  // Método para iniciar una prueba
  void startTest(BuildContext context) {
    _chatManagement.startTest(context);
  }

  // Método para ver un chat específico
  void viewChat(BuildContext context, int chatId) {
    _chatManagement.viewChat(context, chatId);
  }
}

