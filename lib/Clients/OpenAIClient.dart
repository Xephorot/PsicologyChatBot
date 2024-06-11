
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';

//TODO: Limpiar Codigo
class OpenAIClient {
  static OpenAI? openAI;
  static bool _isInitialized = false;

  static Future<void> initialize(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? apiKey = prefs.getString('OPENAI_API_KEY') ?? dotenv.env['OPENAI_API_KEY'];
    if (apiKey == null || apiKey.isEmpty) {
      await _showApiKeyDialog(context);
      return;
    }
    try {
      openAI = OpenAI.instance.build(
        token: apiKey,
        baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 5)),
        enableLog: true,
      );
      _isInitialized = true;
    } catch (e) {
      print('Error initializing OpenAI: $e');
      await _showApiKeyDialog(context);
    }
  }

  static OpenAI getInstance() {
    if (!_isInitialized || openAI == null) {
      throw Exception('OpenAIClient has not been initialized. Call initialize() first.');
    }
    return openAI!;
  }

  static Future<void> setApiKey(String apiKey) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('OPENAI_API_KEY', apiKey);
    openAI?.setToken(apiKey);
  }

  static Future<void> _showApiKeyDialog(BuildContext context) async {
    final TextEditingController apiKeyController = TextEditingController();
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter OpenAI API Key'),
          content: TextField(
            controller: apiKeyController,
            decoration: InputDecoration(hintText: 'API Key'),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Submit'),
              onPressed: () async {
                final String apiKey = apiKeyController.text;
                if (apiKey.isNotEmpty) {
                  await setApiKey(apiKey);
                  Navigator.of(context).pop();
                  await initialize(context);
                }
              },
            ),
          ],
        );
      },
    );
  }

  static bool get isInitialized => _isInitialized;
}