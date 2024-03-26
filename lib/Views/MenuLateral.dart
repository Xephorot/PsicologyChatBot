import 'package:chatbot_psicologia/Views/MenuLateral/NewChatTile.dart';
import 'package:chatbot_psicologia/Views/MenuLateral/StartTestTile.dart';
import 'package:chatbot_psicologia/Views/MenuLateral/UserProfile.dart';
import 'package:chatbot_psicologia/Views/MenuLateral/ViewChatTile.dart';
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
          StartTestTile(),
          NewChatTile(),
          ViewChatTile(chatId: 1),
        ],
      ),
    );
  }
}
