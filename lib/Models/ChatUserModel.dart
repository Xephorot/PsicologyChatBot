import 'package:dash_chat_2/dash_chat_2.dart';

class ChatUserModel {
  static final ChatUser currentUser = ChatUser(id: '1', firstName: 'Sergio', lastName: 'Escalante');
  static final ChatUser gptChatUser = ChatUser(id: '2', firstName: 'Sigmund', lastName: 'Bot');
}
class ChatMessageModel {
  static List<ChatMessage> messages = <ChatMessage>[];
  static List<ChatUser> typingUsers = <ChatUser>[];
}

