import 'package:dash_chat_2/dash_chat_2.dart';

// Definición de los modelos de usuario del chat.
class ChatUserModel {
  //Usuario Principal
  static final ChatUser currentUser = ChatUser(id: '1', firstName: 'Sergio', lastName: 'Escalante');
  //Usuario de OpenAI
  static final ChatUser gptChatUser = ChatUser(id: '2', firstName: 'Sigmund', lastName: 'Bot');
}

// Definición de los mensajes del chat.
class ChatMessageModel {
  static List<ChatMessage> messages = <ChatMessage>[];
  static List<ChatUser> typingUsers = <ChatUser>[];
}
