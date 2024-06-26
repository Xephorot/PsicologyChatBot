// VoiceController.dart

// ignore_for_file: avoid_print

import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:chatbot_psicologia/Controllers/TextToSpeech/TtsController.dart';

class VoiceController {
  late stt.SpeechToText _speech;
  bool isListening = false;
  bool isInitialized = false;
  late TTSController ttsController;

  VoiceController({required this.ttsController}) {
    _speech = stt.SpeechToText();
  }

  Future<void> initialize() async {
    if (!isInitialized) {
      isInitialized = await _speech.initialize(
        onStatus: (status) {
          isListening = status == 'listening';
        },
        onError: (errorNotification) {
          print('Error: ${errorNotification.errorMsg}');
          if (errorNotification.errorMsg == 'error_no_match') {
            print('No match found, please try again.');
          }
        },
      );
      if (!isInitialized) {
        print(
            'The user has denied the use of speech recognition, or it is not available on the device.');
      } else {
        print('Speech recognition initialized successfully.');
      }
    }
  }

  void toggleListening(Function(String) onResult, Function onListeningChange) async {
    if (isListening) {
      await _speech.stop();
      isListening = false;
    } else {
      await ttsController.stop();
      try {
        await _speech.listen(
          onResult: (result) {
            if (result.finalResult) {
              onResult(result.recognizedWords);
            }
          },
        );
        isListening = true;
      } catch (e) {
        print('Error starting speech recognition: $e');
      }
    }
    onListeningChange();
  }
}
