// ignore_for_file: use_build_context_synchronously

import 'package:chatbot_psicologia/Clients/OpenAIClient.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangeApiKeyTile extends StatelessWidget {
  const ChangeApiKeyTile({super.key});

  Future<void> _changeApiKey(BuildContext context) async {
    final TextEditingController controller = TextEditingController();
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Cambiar API Key'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: 'Ingrese nueva API Key'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Guardar'),
              onPressed: () async {
                await prefs.setString('OPENAI_API_KEY', controller.text);
                OpenAIClient.setApiKey(controller.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.key),
      title: const Text('Cambiar API Key'),
      onTap: () => _changeApiKey(context),
    );
  }
}
