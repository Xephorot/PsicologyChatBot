import 'package:flutter/material.dart';
import 'package:chatbot_psicologia/Controllers/TextToSpeech/TtsController.dart';
import 'package:chatbot_psicologia/Models/ChatUserModel.dart';
import 'package:dash_chat_2/dash_chat_2.dart';

class TTSResponseSpeaker extends StatefulWidget {
  final List<ChatMessage> messages;
  final TTSController ttsController;

  const TTSResponseSpeaker({
    super.key,
    required this.messages,
    required this.ttsController,
  });

  @override
  _TTSResponseSpeakerState createState() => _TTSResponseSpeakerState();
}

class _TTSResponseSpeakerState extends State<TTSResponseSpeaker> {
  String lastSpokenText = '';

  @override
  void didUpdateWidget(TTSResponseSpeaker oldWidget) {
    super.didUpdateWidget(oldWidget);
    _speakLastResponse();
  }

  void _speakLastResponse() {
    if (widget.ttsController.isTtsEnabled) {
      final responseMessages = widget.messages
          .where((message) => message.user.id == ChatUserModel.gptChatUser.id)
          .toList();
      if (responseMessages.isNotEmpty) {
        final latestResponse = responseMessages.first.text;
        if (latestResponse != lastSpokenText) {
          widget.ttsController.speak(latestResponse);
          lastSpokenText = latestResponse;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
