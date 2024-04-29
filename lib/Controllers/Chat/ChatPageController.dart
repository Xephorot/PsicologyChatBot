import 'package:chatbot_psicologia/Controllers/Core/getChatResponse.dart';
import 'package:chatbot_psicologia/Models/ChatModel.dart';
import 'package:chatbot_psicologia/Models/ChatUserModel.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';

class ChatController {
  final ChatModel model;

  ChatController(this.model);

  void handleMessageSend(ChatMessage message, Function updateState, BuildContext context) {
    if (!model.isSendButtonEnabled) return;

    model.setSendButtonState(false);
    updateState();

    getChatResponse(message, () {
      updateState();
    }, (newStressLevel) {
      model.updateStressLevel(newStressLevel);
      updateState();
    }, (error) {
      showErrorDialog(context, error);
      model.setSendButtonState(true);
      updateState();
    });

    Future.delayed(const Duration(seconds: 3), () {
      model.setSendButtonState(true);
      updateState();
    });
  }

  void showErrorDialog(BuildContext context, Exception error) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text('Error: ${error.toString()}'),
          actions: <Widget>[
            TextButton(
              child: const Text('Reintentar'),
              onPressed: () {
                ChatMessageModel.typingUsers.remove(ChatUserModel.gptChatUser);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
