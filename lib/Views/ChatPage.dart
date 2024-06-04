import 'package:chatbot_psicologia/Clients/OpenAIClient.dart';
import 'package:chatbot_psicologia/Controllers/TextToSpeech/TtsController.dart';
import 'package:chatbot_psicologia/Views/Widgets/ChatPage/TtsResponseSpeaker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:chatbot_psicologia/Models/ChatUserModel.dart';
import 'package:chatbot_psicologia/Models/ChatModel.dart';
import 'package:chatbot_psicologia/Controllers/Chat/ChatPageController.dart';
import 'package:chatbot_psicologia/Controllers/Chat/VoiceController.dart';
import 'package:chatbot_psicologia/Views/Widgets/ChatPage/MenuLateral.dart';
import 'package:chatbot_psicologia/Views/Widgets/ChatPage/StressLevelIndicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ChatModel model = ChatModel();
  late final ChatController controller;
  late final VoiceController voiceController;
  late final TTSController ttsController;
  String _text = '';

  @override
  void initState() {
    super.initState();
    controller = ChatController(model);
    voiceController = VoiceController();
    ttsController = TTSController();
    voiceController.initialize();

    _checkApiKey();
  }

  void updateState() {
    setState(() {});
  }

  Future<void> _checkApiKey() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final apiKey = prefs.getString('OPENAI_API_KEY');
    if (apiKey == null || apiKey.isEmpty) {
      _showApiKeyDialog();
    } else {
      await OpenAIClient.initialize();
    }
  }

  Future<void> _showApiKeyDialog() async {
    final TextEditingController controller = TextEditingController();
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ingresar API Key'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: 'Ingrese nueva API Key'),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Guardar'),
              onPressed: () async {
                final newApiKey = controller.text;
                await prefs.setString('OPENAI_API_KEY', newApiKey);
                await OpenAIClient.setApiKey(newApiKey);
                Navigator.of(context).pop();
                await OpenAIClient.initialize();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Center(
          child: StressLevelIndicator(stressLevel: model.stressLevelPercentage),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: Icon(ttsController.isTtsEnabled ? Icons.volume_up : Icons.volume_off),
            onPressed: () {
              setState(() {
                ttsController.toggleTts();
              });
            },
          ),
        ],
      ),
      drawer: const MenuLateral(),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                DashChat(
                  currentUser: ChatUserModel.currentUser,
                  typingUsers: ChatMessageModel.typingUsers,
                  messageOptions: const MessageOptions(
                    currentUserContainerColor: Color.fromARGB(255, 57, 122, 60),
                    containerColor: Colors.green,
                    textColor: Colors.white,
                  ),
                  inputOptions: InputOptions(
                    maxInputLength: 200,
                    inputDecoration: InputDecoration(
                      suffixIcon: Container(
                        decoration: BoxDecoration(
                          color: voiceController.isListening ? Colors.greenAccent : Colors.green,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: IconButton(
                          icon: Icon(
                              voiceController.isListening ? Icons.mic_off : Icons.mic,
                              color: Colors.white),
                          onPressed: () {
                            if (!voiceController.isInitialized) {
                              if (kDebugMode) {
                                print('Please wait, initializing speech recognition.');
                              }
                            } else {
                              voiceController.toggleListening((text) {
                                setState(() {
                                  _text = text;
                                  if (text.isNotEmpty) {
                                    final message = ChatMessage(
                                      text: text,
                                      user: ChatUserModel.currentUser,
                                      createdAt: DateTime.now(),
                                    );
                                    controller.handleMessageSend(message, updateState, context);
                                  }
                                });
                              }, () {
                                setState(() {});
                              });
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  onSend: (message) => controller.handleMessageSend(message, updateState, context),
                  messages: ChatMessageModel.messages,
                ),
                TTSResponseSpeaker(
                  messages: ChatMessageModel.messages,
                  ttsController: ttsController,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Input por Voz: $_text'),
          ),
        ],
      ),
    );
  }
}
