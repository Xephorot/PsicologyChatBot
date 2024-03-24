import 'package:chatbot_psicologia/Models/ChatUserModel.dart';


void restartChat(Function() updateStateCallback) {

  ChatMessageModel.messages.clear();
  ChatMessageModel.typingUsers.clear();

  updateStateCallback();
}


