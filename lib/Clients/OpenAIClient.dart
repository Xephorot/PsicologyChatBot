// lib/open_ai_client.dart
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OpenAIClient {
  static late OpenAI openAI;
  static bool _isInitialized = false;

  static Future<void> initialize() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? apiKey = prefs.getString('OPENAI_API_KEY') ?? dotenv.env['OPENAI_API_KEY'];

    if (apiKey == null) {
      throw Exception('API Key not found');
    }

    openAI = OpenAI.instance.build(
      token: apiKey,
      baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 5)),
      enableLog: true,
    );

    _isInitialized = true;
  }

  static OpenAI getInstance() {
    if (!_isInitialized) {
      throw Exception('OpenAIClient has not been initialized. Call initialize() first.');
    }
    return openAI;
  }

  static Future<void> setApiKey(String apiKey) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('OPENAI_API_KEY', apiKey);
    openAI.setToken(apiKey);
  }
}
