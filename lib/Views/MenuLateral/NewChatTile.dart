import 'package:chatbot_psicologia/Controllers/Chat/ChatController.dart';
import 'package:chatbot_psicologia/Views/ChatPage.dart';
import 'package:flutter/material.dart';

class NewChatTile extends StatelessWidget {
  const NewChatTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.plus_one),
      title: const Text('Nuevo Chat'),
      onTap: () async {
        // Asumiendo que restartAndSaveChat es un Future<void>
        await ChatController.instance.restartAndSaveChat(context);
        openChatScreen(context);
      },
    );
  }
}

void openChatScreen(BuildContext context) {
  Navigator.of(context).push(PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => ChatPage(),
    transitionDuration: Duration(milliseconds: 350),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.easeOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  ));
}