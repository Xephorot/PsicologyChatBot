import 'package:chatbot_psicologia/Controllers/MenuLateral/NewChatTile.dart';
import 'package:chatbot_psicologia/Controllers/MenuLateral/UserProfile.dart';
import 'package:flutter/material.dart';

class MenuLateral extends StatelessWidget {
  const MenuLateral({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: const <Widget>[
          UserProfile(),
          NewChatTile(),
        ],
      ),
    );
  }
}