import 'package:chatbot_psicologia/Controllers/ProfileEdition.dart';
import 'package:chatbot_psicologia/Controllers/restartchat.dart';
import 'package:flutter/material.dart';

//TODO: Limpiar Codigo, Implementar MVC y Builder.
class MenuLateral extends StatelessWidget {
  const MenuLateral({super.key});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          //*Este es el perfil de usuario
          ValueListenableBuilder(
            valueListenable: ProfileEditor.instance.profileNotifier,
            builder: (context, Profile profile, child) {
              return GestureDetector(
                onTap: () {
                  ProfileEditor.instance.editProfile(context);
                },
                child: UserAccountsDrawerHeader(
                  accountName: Text(profile.username),
                  accountEmail: const Text(""),
                  currentAccountPicture: const CircleAvatar(
                    child: FlutterLogo(size: 45.0),
                  ),
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(139, 0, 0, 1),
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.chat),
            title: const Text('Iniciar Test'),
            onTap: () {
              //TODO: Implementar logica de ver inciar el test y ver los demas chat hechos.
              Navigator.of(context).pop(); // Cierra el menú
            },
          ),
          ListTile(
            leading: const Icon(Icons.plus_one),
            title: const Text('Nuevo Chat'),
            onTap: () {
              //! Por alguna razon no funca ahora, pero antes si, arreglar
              restartChat(() {});
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: const Icon(Icons.chat),
            title: const Text('Chat 1'),
            onTap: () {
              //TODO: Implementar logica de ver chat 1 y ver los demas chat hechos.
              Navigator.of(context).pop(); // Cierra el menú
            },
          ),
        ],
      ),
    );
  }
}
