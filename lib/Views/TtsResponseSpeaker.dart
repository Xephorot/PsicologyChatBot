import 'package:flutter/material.dart';
import 'package:chatbot_psicologia/Controllers/TextToSpeech/TtsController.dart';
import 'package:chatbot_psicologia/Models/ChatUserModel.dart';
import 'package:dash_chat_2/dash_chat_2.dart';

class TTSResponseSpeaker extends StatelessWidget {
  final TTSController ttsController;

  const TTSResponseSpeaker({
    Key? key,
    required this.ttsController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  void speakLastResponse(List<ChatMessage> messages) {
    if (ttsController.isTtsEnabled) {
      final responseMessages = messages
          .where((message) => message.user.id == ChatUserModel.gptChatUser.id)
          .toList();
      if (responseMessages.isNotEmpty) {
        final latestResponse = responseMessages.first.text;
        ttsController.speak(latestResponse);
      }
    }
  }
}
