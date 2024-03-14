import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:chatbot_psicologia/consts.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';

// Definición de la página de chat como un StatefulWidget
class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  // Creación del estado de la página de chat
  State<ChatPage> createState() => _ChatPageState();
}

// Definición del estado de la página de chat
class _ChatPageState extends State<ChatPage> {
  // Creación de una instancia de OpenAI con la clave de API y opciones de configuración
  final _openAI = OpenAI.instance.build(
    token: OPENAI_API_KEY,
    baseOption: HttpSetup(
      receiveTimeout: const Duration(
        seconds: 5,
      ),
    ),
    enableLog: true,
  );

  // Definición del usuario actual
  final ChatUser _currentUser =
      ChatUser(id: '1', firstName: 'Hussain', lastName: 'Mustafa');

  // Definición del usuario del chat GPT
  final ChatUser _gptChatUser =
      ChatUser(id: '2', firstName: 'Chat', lastName: 'GPT');

  // Lista de mensajes en el chat
  List<ChatMessage> _messages = <ChatMessage>[];

  // Lista de usuarios que están escribiendo
  List<ChatUser> _typingUsers = <ChatUser>[];

  @override
  // Construcción de la interfaz de la página de chat
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(
          0,
          166,
          126,
          1,
        ),
        title: const Text(
          'GPT Chat',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: DashChat(
          currentUser: _currentUser,
          typingUsers: _typingUsers,
          messageOptions: const MessageOptions(
            currentUserContainerColor: Colors.black,
            containerColor: Color.fromRGBO(
              0,
              166,
              126,
              1,
            ),
            textColor: Colors.white,
          ),
          onSend: (ChatMessage m) {
            getChatResponse(m);
          },
          messages: _messages),
    );
  }

  // Función para obtener la respuesta del chat a partir de un mensaje
  Future<void> getChatResponse(ChatMessage m) async {
    setState(() {
      // Insertar el mensaje en la lista de mensajes y añadir el usuario GPT a la lista de usuarios que están escribiendo
      _messages.insert(0, m);
      _typingUsers.add(_gptChatUser);
    });
    // Crear el historial de mensajes
    List<Messages> _messagesHistory = _messages.reversed.map((m) {
      if (m.user == _currentUser) {
        return Messages(role: Role.user, content: m.text);
      } else {
        return Messages(role: Role.assistant, content: m.text);
      }
    }).toList();
    // Crear la solicitud de completado de chat
    final request = ChatCompleteText(
      model: GptTurbo0301ChatModel(),
      messages: _messagesHistory.map((m) => m.toJson()).toList(),
      maxToken: 200,
    );
    // Obtener la respuesta de la API de OpenAI
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