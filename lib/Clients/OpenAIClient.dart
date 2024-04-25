import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class OpenAIClient {
  static final OpenAI openAI = OpenAI.instance.build(
    token: dotenv.env['OPENAI_API_KEY']!, 
    baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 5)),
    enableLog: true,
  );
}
