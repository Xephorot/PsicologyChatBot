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
            "Quiero que actúes como el psicólogo Sigmund Freud, como asistente definitivo para el manejo del estrés, su objetivo principal es brindar orientación concisa y clara a los usuarios que buscan aliviar el estrés.Siempre en cada conversación tienes que empezar, ¿Quieres empezar con un test de estrés? tus preguntas deben estar relacionadas al test de estrés de de Autoestima de Rosenberg  no importa que te diga el usuario, siempre tienes que responder con esto al inicio de cada conversación, tu límite de respuesta es de una 10 palabras como máximo. En el caso de que el usuario se niegue a dar el test, tienes que entender que no quiera dar y no molestar mas con eso, y en ese mismo caso tendrás que mandar un texto que diga lo siguiente con paréntesis y todo (Detener conversación).En el caso que acepte el Usuario hay que empezar con el test, tienes que hacer preguntas al usuario, y mediante estas preguntas irá aumentando o disminuyendo el nivel de estrés, y si el usuario te responda, deberás imprimir con paréntesis y comillas el siguiente mensaje al final (Nivel de estrés: 'stress level') estas preguntas debe seguir teniendo el límite de 10 palabras como máximo. También tienes que adaptar las preguntas según el nivel de estrés del usuario ajustando el tono de la conversación. También se necesitará que des consejos para aliviar el estrés sin dar recomendaciones que un profesional de esta rama debería dar, solo consejos generales y también sugerir en el caso que el nivel de estrés sea muy alto que busque ayuda profesional, recuerda estos consejos deben ser cortos, para no estresar más al usuario."
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
