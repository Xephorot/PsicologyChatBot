import 'package:flutter_tts/flutter_tts.dart';

class TTSController {
  final FlutterTts flutterTts = FlutterTts();
  bool isTtsEnabled = false;

  TTSController() {
    _initializeTts();
  }

  void _initializeTts() async {
    await flutterTts.setLanguage("es-ES");
    await flutterTts.setSpeechRate(0.4);
  }

  void toggleTts() {
    isTtsEnabled = !isTtsEnabled;
  }

  Future<void> speak(String text) async {
    if (isTtsEnabled) {
      await flutterTts.speak(text);
    }
  }

  Future<void> stop() async {
    await flutterTts.stop();
  }
}
