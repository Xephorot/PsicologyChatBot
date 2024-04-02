import 'package:chatbot_psicologia/Controllers/RosenbergTestController.dart';
import 'package:flutter/material.dart';

class RosenbergTestScreen extends StatefulWidget {
  const RosenbergTestScreen({super.key});

  @override
  _RosenbergTestScreenState createState() => _RosenbergTestScreenState();
}

class _RosenbergTestScreenState extends State<RosenbergTestScreen> {
  final controller = RosenbergTestController();
  int currentQuestionIndex = 0;
  List<int> userAnswers = [];

  @override
  Widget build(BuildContext context) {
    final currentQuestion = controller.questions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Test de Autoestima de Rosenberg'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(currentQuestion.questionText),
            ...currentQuestion.answers.asMap().entries.map((entry) {
              int idx = entry.key;
              String answer = entry.value;
              return ListTile(
                title: Text(answer),
                leading: Radio(
                  value: idx,
                  groupValue: userAnswers.length > currentQuestionIndex
                      ? userAnswers[currentQuestionIndex]
                      : null,
                  onChanged: (int? value) {
                    setState(() {
                      if (userAnswers.length == currentQuestionIndex) {
                        userAnswers.add(value!);
                      } else {
                        userAnswers[currentQuestionIndex] = value!;
                      }
                    });
                  },
                ),
              );
            }).toList(),
            ElevatedButton(
              onPressed: () {
                if (currentQuestionIndex < controller.questions.length - 1) {
                  setState(() {
                    currentQuestionIndex++;
                  });
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      content: Text(
                          'Tu puntuación es: ${controller.calculateScore(userAnswers)}'),
                      actions: <Widget>[
                        ElevatedButton(
                          onPressed: () async {
                            // Hacer la función onPressed asíncrona
                            if (currentQuestionIndex <
                                controller.questions.length - 1) {
                              setState(() {
                                currentQuestionIndex++;
                              });
                            } else {
                              // Calcula el porcentaje y muestra el diálogo
                              int percentage =
                                  controller.calculateScore(userAnswers);
                              await showDialog(
                                context: context,
                                barrierDismissible:
                                    false, // Asegúrate de que el diálogo no pueda cerrarse tocando fuera de él
                                builder: (context) => AlertDialog(
                                  content: Text(
                                      'Tu nivel de autoestima es: $percentage%'),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pop();
                                        Navigator.of(context)
                                            .pop(); 
                                      },
                                      child: Text('OK'),
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                          child: Text(currentQuestionIndex <
                                  controller.questions.length - 1
                              ? 'Siguiente'
                              : 'Finalizar'),
                        ),
                      ],
                    ),
                  );
                }
              },
              child: Text(currentQuestionIndex < controller.questions.length - 1
                  ? 'Siguiente'
                  : 'Finalizar'),
            ),
          ],
        ),
      ),
    );
  }
}
