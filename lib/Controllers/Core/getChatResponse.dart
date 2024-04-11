import 'dart:convert';
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

  final request = ChatCompleteText(
    model: GptTurbo0301ChatModel(),
    messages: [
      {
        "role": "system",
        "content":
            "Actúa como Freud, ofreciendo orientación sobre el estrés. Inicia con un test de estrés que se basa en el test de estrés de de Autoestima de Rosenberg cada mensaje que des debe ser menos de 10 palabras, solo debes dar una pregunta por cada respuesta. Si se niegan, tienes que decir al final de la conversación (Deteniendo Conversación); si no, evalúa su nivel de estrés, también debes mostrar este en cada respuesta tuya el nivel de estrés de la siguiente manera: (Nivel de estrés: Nivel). Da consejos generales, y si el estrés es alto, recomienda ayuda profesional."
      },
      ...messagesHistory.map((m) => m.toJson())
    ],
    temperature: 0.1,
  );

  final response = await OpenAIClient.openAI.onChatCompletion(request: request);

  if (response != null && response.choices.isNotEmpty) {
    for (var element in response.choices) {
      if (element.message != null) {
        print('ChatGPT: ${element.message!.content}');
        
        ChatMessageModel.messages.insert(
          0,
          ChatMessage(
            user: ChatUserModel.gptChatUser,
            createdAt: DateTime.now(),
            text: element.message!.content,
          ),
        );
      }
    }
    updateStateCallback();
  }

  for (var message in ChatMessageModel.messages) {
    print('${message.user.runtimeType}: ${message.text}');
  }

  ChatMessageModel.typingUsers.remove(ChatUserModel.gptChatUser);
  updateStateCallback();
}
