import 'package:chatbot_psicologia/Views/Widgets/Start/Animations/LiquidAnimation.dart';
import 'package:chatbot_psicologia/Views/Widgets/Start/AppTitle.dart';
import 'package:chatbot_psicologia/Views/Widgets/Start/StartButton.dart';
import 'package:chatbot_psicologia/Views/Widgets/Start/WelcomMessage.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      body: const Stack(
        children: <Widget>[
          LiquidAnimation(),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  AppTitle(),
                  SizedBox(height: 20.0),
                  WelcomeMessage(),
                  SizedBox(height: 40.0),
                  StartButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
