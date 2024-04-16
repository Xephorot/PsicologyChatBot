import 'package:flutter/material.dart';

class ChatStressLevelCalculator extends StatefulWidget {
  final double nivelEstresPorcentaje;
  final Function onStressLevelChanged;

  const ChatStressLevelCalculator({
    super.key,
    required this.nivelEstresPorcentaje,
    required this.onStressLevelChanged,
  });

  @override
  _ChatStressLevelCalculatorState createState() => _ChatStressLevelCalculatorState();
}

class _ChatStressLevelCalculatorState extends State<ChatStressLevelCalculator> {
  @override
  Widget build(BuildContext context) {
    
    return Container(); 
  }

}
