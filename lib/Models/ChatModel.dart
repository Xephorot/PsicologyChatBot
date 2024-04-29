
class ChatModel {
  double stressLevelPercentage = 0.0;
  bool isSendButtonEnabled = true;

  void updateStressLevel(double newLevel) {
    stressLevelPercentage = newLevel;
  }

  void setSendButtonState(bool state) {
    isSendButtonEnabled = state;
  }
}
