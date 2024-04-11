import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class StressLevelIndicator extends StatelessWidget {
  final double stressLevel;

  const StressLevelIndicator({Key? key, required this.stressLevel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GFProgressBar(
      percentage: stressLevel,
      lineHeight: 20,
      alignment: MainAxisAlignment.spaceBetween,
      leading: const Icon(Icons.sentiment_satisfied, color: Colors.green),
      trailing: const Icon(Icons.sentiment_dissatisfied, color: Colors.red),
      backgroundColor: Colors.black12,
      progressBarColor: GFColors.DANGER,
    );
  }
}
