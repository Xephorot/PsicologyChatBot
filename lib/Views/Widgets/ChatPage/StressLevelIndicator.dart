import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class StressLevelIndicator extends StatelessWidget {
  final double stressLevel;

  const StressLevelIndicator({super.key, required this.stressLevel});

  @override
  Widget build(BuildContext context) {
    return GFProgressBar(
      percentage: stressLevel,
      lineHeight: 20,
      alignment: MainAxisAlignment.spaceBetween,
      leading: const Icon(Icons.sentiment_satisfied, color: Colors.white),
      trailing: const Icon(Icons.sentiment_dissatisfied, color: Colors.white),
      backgroundColor: Colors.black12,
      progressBarColor: GFColors.INFO,
    );
  }
}
