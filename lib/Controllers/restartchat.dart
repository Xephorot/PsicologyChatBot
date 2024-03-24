import 'package:chatbot_psicologia/Models/ChatMessageModel.dart';
import 'package:chatbot_psicologia/Models/ChatUserModel.dart';
import 'package:dash_chat_2/dash_chat_2.dart';


void restartChat(Function() updateStateCallback, {bool sendWelcomeMessage = false}) {

  ChatMessageModel.messages.clear();

  
  ChatMessageModel.typingUsers.clear();

  
  if (sendWelcomeMessage) {
    final welcomeMessage = ChatMessage(
      user: ChatUserModel.gptChatUser, 
      createdAt: DateTime.now(),
      text: "¡Hola! ¿Cómo puedo ayudarte hoy?",
    );

    ChatMessageModel.messages.insert(0, welcomeMessage);
  }
  updateStateCallback();
}


