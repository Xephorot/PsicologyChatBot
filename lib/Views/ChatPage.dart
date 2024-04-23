import 'package:chatbot_psicologia/Views/StressLevelIndicator.dart';
import 'package:flutter/material.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:chatbot_psicologia/Controllers/Core/getChatResponse.dart';
import 'package:chatbot_psicologia/Views/MenuLateral.dart';
import 'package:chatbot_psicologia/Models/ChatUserModel.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  double nivelEstresPorcentaje = 0.0;
  bool isSendButtonEnabled = true;

  void _handleMessageSend(ChatMessage message) {
    if (!isSendButtonEnabled) return;

    isSendButtonEnabled = false;
    getChatResponse(message, () {
      setState(() {});
    }, (newStressLevel) {
      setState(() {
        nivelEstresPorcentaje = newStressLevel;
      });
    }, (error) {
      _showErrorDialog(error);
    });

    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        isSendButtonEnabled = true;
      });
    });
  }

  void _showErrorDialog(Exception error) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(139, 0, 0, 1),
        title: Center(
          child: StressLevelIndicator(stressLevel: nivelEstresPorcentaje),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: const MenuLateral(),
      body: DashChat(
        currentUser: ChatUserModel.currentUser,
        typingUsers: ChatMessageModel.typingUsers,
        messageOptions: const MessageOptions(
          currentUserContainerColor: Colors.black,
          containerColor: Color.fromRGBO(139, 0, 0, 1),
          textColor: Colors.white,
        ),
        inputOptions: const InputOptions(
          maxInputLength: 200,
        ),
        onSend: _handleMessageSend,
        messages: ChatMessageModel.messages,
      ),
    );
  }
}
