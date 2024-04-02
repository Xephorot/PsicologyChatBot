import 'package:chatbot_psicologia/Models/RosenbergQuestion.dart';

class RosenbergTestController {
  final List<RosenbergQuestion> questions = [
    RosenbergQuestion(
      questionText:
          'Me siento una persona de valor, al menos en igual medida a los demás.',
      answers: [
        'Totalmente de acuerdo',
        'De acuerdo',
        'En desacuerdo',
        'Totalmente en desacuerdo'
      ],
    ),
    //TODO: Agregar mas preguntas
  ];
  //TODO: Ajustar puntuacion de acuerdo al metodo que se usa
  int calculateScore(List<int> userAnswers) {
    int score = 0;
    for (var answer in userAnswers) {
      score += answer;
    }
    double percentage = (score / (3 * questions.length)) * 100;
    return percentage.round();
  }
}
