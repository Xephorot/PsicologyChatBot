import 'package:flutter/material.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:chatbot_psicologia/Controllers/Core/getChatResponse.dart';
import 'package:chatbot_psicologia/Views/MenuLateral.dart';
import 'package:chatbot_psicologia/Models/ChatUserModel.dart';
import 'package:getwidget/getwidget.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  double nivelEstresPorcentaje = 0.0; // Inicia en 0%

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(139, 0, 0, 1),
        title: Center(
          child: GFProgressBar(
            percentage: nivelEstresPorcentaje,
            lineHeight: 20,
            alignment: MainAxisAlignment.spaceBetween,
            leading: const Icon(Icons.sentiment_satisfied, color: Colors.green), // Ícono ahora en leading
            trailing: const Icon(Icons.sentiment_dissatisfied, color: Colors.red), // Ícono ahora en trailing
            backgroundColor: Colors.black12,
            progressBarColor: GFColors.DANGER,
          ),
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
        onSend: (ChatMessage m) {
          getChatResponse(m, () {
            setState(() {
              // Incrementa el nivel de estrés por cada mensaje enviado
              nivelEstresPorcentaje += 0.1;
              if (nivelEstresPorcentaje > 1) nivelEstresPorcentaje = 1; // Asegura que no sea mayor a 100%
            });
          });
        },
        messages: ChatMessageModel.messages,
      ),
    );
  }
}
