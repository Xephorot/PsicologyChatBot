import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class LiquidAnimation extends StatelessWidget {
  const LiquidAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 2,
        child: WaveWidget(
          config: CustomConfig(
            gradients: [
              [Colors.green, Colors.greenAccent],
              [Colors.lightGreen, Colors.lightGreenAccent],
            ],
            durations: [35000, 19440],
            heightPercentages: [0.20, 0.25],
            blur: const MaskFilter.blur(BlurStyle.solid, 10),
            gradientBegin: Alignment.bottomLeft,
            gradientEnd: Alignment.topRight,
          ),
          waveAmplitude: 0,
          backgroundColor: Colors.green[50],
          size: const Size(double.infinity, double.infinity),
        ),
      ),
    );
  }
}
