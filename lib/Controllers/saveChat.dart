import 'dart:convert';
import 'package:chatbot_psicologia/Models/ChatUserModel.dart';


String saveChatToJSON() {
 
  List<Map<String, dynamic>> messagesJson = ChatMessageModel.messages.map((message) {
    return {
      'user': message.user.id, 
      'createdAt': message.createdAt.toIso8601String(),
      'text': message.text,
    };
  }).toList();

  String chatJson = jsonEncode(messagesJson);

  return chatJson;
}
