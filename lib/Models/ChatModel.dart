class ChatModel {
  double stressLevelPercentage = 0.0;
  bool isSendButtonEnabled = true;
  bool speakResponses = false; 

  void updateStressLevel(double newLevel) {
    stressLevelPercentage = newLevel;
  }

  void setSendButtonState(bool state) {
    isSendButtonEnabled = state;
  }

  void setSpeakResponses(bool state) {
    speakResponses = state;
  }
}
