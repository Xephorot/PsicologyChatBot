import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:chatbot_psicologia/Views/MenuLateral.dart';
import 'package:chatbot_psicologia/consts.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

//TODO: Limpiar Codigo, Implementar MVC y Builder.
class _ChatPageState extends State<ChatPage> {
  final _openAI = OpenAI.instance.build(
    token: OPENAI_API_KEY,
    baseOption: HttpSetup(
      receiveTimeout: const Duration(
        seconds: 5,
      ),
    ),
    enableLog: true,
  );
  
  final ChatUser _currentUser =
      ChatUser(id: '1', firstName: 'Sergio', lastName: 'Escalante');

  final ChatUser _gptChatUser =
      ChatUser(id: '2', firstName: 'Elver', lastName: 'Galarga');

  final List<ChatMessage> _messages = <ChatMessage>[];

  final List<ChatUser> _typingUsers = <ChatUser>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(
          139,
          0,
          0,
          1,
        ),
        title: const Text(
          'Anti Estress Bot',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white), // Color del icono del menu lateral
      ),
      drawer: const MenuLateral(), //Integracion del menu lateral
      body: DashChat(
          currentUser: _currentUser,
          typingUsers: _typingUsers,
          messageOptions: const MessageOptions(
            currentUserContainerColor: Colors.black,
            containerColor: Color.fromRGBO(
              139,
              0,
              0,
              1,
            ),
            textColor: Colors.white,
          ),
          onSend: (ChatMessage m) {
            getChatResponse(m);
          },
          // Aquí se establece el historial de mensajes
          messages: _messages),
    );
  }

  //Aqui se obtiene la respuesta del chat
  Future<void> getChatResponse(ChatMessage m) async {
    setState(() {
      _messages.insert(0, m);
      _typingUsers.add(_gptChatUser);
    });

    // Obtener el historial de mensajes
    List<Messages> messagesHistory = _messages.reversed.map((m) {
      if (m.user == _currentUser) {
        return Messages(role: Role.user, content: m.text);
      } else {
        return Messages(role: Role.assistant, content: m.text);
      }
    }).toList();
    // Crear la solicitud para obtener la respuesta del chat
    final request = ChatCompleteText(
      model: GptTurbo0301ChatModel(),
      messages: messagesHistory.map((m) => m.toJson()).toList(),
      maxToken: 150,
    );

    final response = await _openAI.onChatCompletion(request: request);
    for (var element in response!.choices) {
      if (element.message != null) {
        setState(() {
          // Insertar la respuesta en la lista de mensajes
          _messages.insert(
            0,
            ChatMessage(
                user: _gptChatUser,
                createdAt: DateTime.now(),
                text: element.message!.content),
          );
        });
      }
    }
    setState(() {
      // Eliminar el usuario GPT de la lista de usuarios que están escribiendo
      _typingUsers.remove(_gptChatUser);
    });
  }
}
