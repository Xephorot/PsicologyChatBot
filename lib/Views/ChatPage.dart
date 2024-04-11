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
  double nivelEstresPorcentaje = 0.0; // Paso 2: Estado para nivel de estrés

  void _handleMessageSend(ChatMessage message) {
    // Aquí puedes implementar la lógica cuando se envía un mensaje.
    // Por ejemplo, ajustar el nivel de estrés basado en el mensaje.
    getChatResponse(message, () {
      setState(() {
        nivelEstresPorcentaje += 0.1; // Simula el cálculo del nivel de estrés
        if (nivelEstresPorcentaje > 1) nivelEstresPorcentaje = 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(139, 0, 0, 1),
        title: Center(
          child: StressLevelIndicator(stressLevel: nivelEstresPorcentaje), // Paso 2: Usar StressLevelIndicator
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
        onSend: (ChatMessage message) {
          _handleMessageSend(message); // Paso 4: Manejo del envío de mensajes
        },
        messages: ChatMessageModel.messages,
      ),
    );
  }
}
