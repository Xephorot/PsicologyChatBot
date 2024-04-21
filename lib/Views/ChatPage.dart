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

  //Aqui se recibe para actualizar el medidor de estress
  void _handleMessageSend(ChatMessage message) {
    getChatResponse(message, () async {
      await Future.delayed(const Duration(seconds: 3));  // Añadiendo retraso de 3 segundos
      setState(() {});
    }, (newStressLevel) {
      setState(() {
        nivelEstresPorcentaje = newStressLevel;
      });
    });
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
        //Aqui se actualiza el chat
        onSend: (ChatMessage message) {
          _handleMessageSend(message); 
        },
        messages: ChatMessageModel.messages,
      ),
    );
  }
}
