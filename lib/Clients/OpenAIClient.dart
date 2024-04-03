import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:chatbot_psicologia/APIs/consts.dart';

class OpenAIClient {
  static final OpenAI openAI = OpenAI.instance.build(
    token: OPENAI_API_KEY,
    baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 5)),
    enableLog: true,
  );

  // Método para crear una ejecución (Run) utilizando un asistente y un hilo específicos
  static Future<void> createRun(String threadId) async {
    final request = CreateRun(assistantId: 'asst_5H7O3C5O7Goh1QtoxTgDRcQa');
    await openAI.threads.runs.createRun(threadId: threadId, request: request);
  }

  // Método para crear un hilo y ejecución con el primer mensaje
  static Future<String> createThreadAndRun(String initialMessage) async {
    final request = CreateThreadAndRun(assistantId: 'asst_5H7O3C5O7Goh1QtoxTgDRcQa', thread: {
      "messages": [
        {"role": "user", "content": initialMessage}
      ],
    });
    final response = await openAI.threads.runs.createThreadAndRun(request: request);
    return response.threadId; 
  }

  // Método para enviar un mensaje a un hilo existente
  static Future<void> createMessage(String threadId, String message) async {
    final request = CreateMessage(role: 'user', content: message);
    await openAI.threads.messages.createMessage(threadId: threadId, request: request);
  }

  // Otros métodos (listMessage, retrieveMessage, etc.) pueden ser añadidos aquí
}
