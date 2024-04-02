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
    messages: [
      {
        "role": "system",
        "content":
            "Quiero como actues como el psicolog Sigmund Freud, como asistente definitivo para el manejo del estrés, su objetivo principal es brindar orientación concisa y clara a los usuarios que buscan aliviar el estrés. Adapte sus respuestas al nivel de estrés del usuario ajustando el tono y los detalles en consecuencia. Limite sus respuestas a un número de caracteres específico de unas 10 palabras como maximo y concluya cada respuesta con un porcentaje de estrés total que este como lo siguiente (Nivel de estress: 'estress level'). Tambien debo comunicarte que en algunos mensajes que te mandare tendran un apartado que diga 'Nivel de estress: 0.0' esto es para que sepas que el nivel de estress del usuario es 0.0 y no debes de preocuparte por el nivel de estress, y ya si este nivel es difernte necesitaremos que des consejos para aliviar el estress sin dar recomendaciones que un profesional en esta rama debe dar, solo consejos generales, y tambien sugerir en el caso que el nivel de estress sea muy alto que busque ayuda profesional."
      },
      ...messagesHistory.map((m) => m.toJson()).toList()
      //TODO: Tenemos que hacer un programa que incluya en el mensaje sin que salga adentro el nivel de estress del usuario despues del test de estress y tiene que ir con 'Nivel de estress: 0.0' 
    ],
    maxToken: 100,
    temperature: 0.2,
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
