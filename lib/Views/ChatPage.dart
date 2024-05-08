import 'package:chatbot_psicologia/Controllers/TextToSpeech/TtsController.dart';
import 'package:chatbot_psicologia/Views/TtsResponseSpeaker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:chatbot_psicologia/Models/ChatUserModel.dart';
import 'package:chatbot_psicologia/Models/ChatModel.dart';
import 'package:chatbot_psicologia/Controllers/Chat/ChatPageController.dart';
import 'package:chatbot_psicologia/Controllers/Chat/VoiceController.dart';
import 'package:chatbot_psicologia/Views/MenuLateral.dart';
import 'package:chatbot_psicologia/Views/StressLevelIndicator.dart';

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
  }

  void updateState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(139, 0, 0, 1),
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
                    currentUserContainerColor: Colors.black,
                    containerColor: Color.fromRGBO(139, 0, 0, 1),
                    textColor: Colors.white,
                  ),
                  inputOptions: InputOptions(
                    maxInputLength: 200,
                    inputDecoration: InputDecoration(
                      hintText: 'Type here or use voice',
                      suffixIcon: Container(
                        decoration: BoxDecoration(
                          color: voiceController.isListening ? Colors.green : Colors.red,
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
            child: Text('Voice Input: $_text'),
          ),
        ],
      ),
    );
  }
}
