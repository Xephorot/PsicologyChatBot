import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:chatbot_psicologia/Clients/OpenAIClient.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:chatbot_psicologia/Models/ChatUserModel.dart';

Future<void> getChatResponse(
    ChatMessage message, Function() updateStateCallback) async {
  ChatMessageModel.messages.insert(0, message);
  ChatMessageModel.typingUsers.add(ChatUserModel.gptChatUser);
  updateStateCallback();

  List<Messages> messagesHistory = ChatMessageModel.messages.reversed.map((m) {
    if (m.user == ChatUserModel.currentUser) {
      return Messages(role: Role.user, content: m.text);
    } else {
      return Messages(role: Role.assistant, content: m.text);
    }
  }).toList();
  //Aqui se define el modelo de chat que se va a utilizar y el objetivo del chat.
  

  final request = ChatCompleteText(
    model: GptTurbo0301ChatModel(),
    //!Hay que cambiar a un asistente hasta el jueves, por que si no, nos quedaremos sin preosupuesto y tambien imprimir en consola el uso actual de tokens.
    messages: [
      {
        "role": "system",
        "content":
            "nothing"
      },
      ...messagesHistory.map((m) => m.toJson()).toList()
    ],
    maxToken: 3000,
  );
  
  final response = await OpenAIClient.openAI.onChatCompletion(request: request);
  if (response != null && response.choices.isNotEmpty) {
    for (var element in response.choices) {
      if (element.message != null) {
        ChatMessageModel.messages.insert(
          0,
          ChatMessage(
              user: ChatUserModel.gptChatUser,
              createdAt: DateTime.now(),
              text: element.message!.content),
        );
      }
    }
    updateStateCallback();
  }

  ChatMessageModel.typingUsers.remove(ChatUserModel.gptChatUser);
  updateStateCallback();
}

/*
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:chatbot_psicologia/Clients/OpenAIClient.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:chatbot_psicologia/Models/ChatUserModel.dart';

String? globalThreadId;

Future<void> getChatResponse(
    ChatMessage message, Function() updateStateCallback) async {
  ChatMessageModel.messages.insert(0, message);
  ChatMessageModel.typingUsers.add(ChatUserModel.gptChatUser);
  updateStateCallback();

  String threadId;
  if (globalThreadId == null) {
    threadId = await OpenAIClient.createThreadAndRun(message.text);
    globalThreadId = threadId;
  } else {
    threadId = globalThreadId!;
    await OpenAIClient.createMessage(threadId, message.text);
  }

  final messages = await OpenAIClient.listMessage(threadId);

  for (var msg in messages) {
    if (msg.role == 'assistant') {
      ChatMessageModel.messages.insert(
        0,
        ChatMessage(
            user: ChatUserModel.gptChatUser,
            createdAt: DateTime.now(),
            text: msg.content),
      );
    }
  }

  ChatMessageModel.typingUsers.remove(ChatUserModel.gptChatUser);
  updateStateCallback();
}
*/ 