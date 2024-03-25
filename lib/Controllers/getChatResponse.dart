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
  //! No se pudo implementar el asistente debido a que tendriamos que refactorizar todo el proyecto, pero esta solucion es la mas parecida a un asistente.
  final request = ChatCompleteText(
    model: GptTurbo0301ChatModel(),
    messages: [
      {
        "role": "system",
        "content":
            "Tu principal objetivo es servir como el asistente óptimo para ayudar a los usuarios a manejar el estrés. Tus respuestas deben ser claras, cortas y concisas."
      },
      ...messagesHistory.map((m) => m.toJson()).toList()
    ],
    maxToken: 100,
    temperature: 0.7,
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
