import 'package:flutter/material.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:chatbot_psicologia/Models/ChatUserModel.dart';
import 'package:chatbot_psicologia/Models/ChatModel.dart';
import 'package:chatbot_psicologia/Controllers/Chat/ChatPageController.dart';
import 'package:chatbot_psicologia/Views/MenuLateral.dart';
import 'package:chatbot_psicologia/Views/StressLevelIndicator.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ChatModel model = ChatModel();
  late final ChatController controller;

  @override
  void initState() {
    super.initState();
    controller = ChatController(model);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(139, 0, 0, 1),
        title: Center(
          child: StressLevelIndicator(stressLevel: model.stressLevelPercentage),
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
        onSend: (message) => controller.handleMessageSend(message, () => setState(() {}), context),
        messages: ChatMessageModel.messages,
      ),
    );
  }
}
