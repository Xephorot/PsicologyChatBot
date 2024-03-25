import 'package:chatbot_psicologia/Controllers/restartchat.dart';
import 'package:flutter/material.dart';

//TODO: Limpiar Codigo, Implementar MVC y Builder.
class MenuLateral extends StatelessWidget{
  const MenuLateral({super.key});
  void _handleNewChat(BuildContext context) {
    // Llama a restartChat para limpiar el estado del chat
    restartChat(() {
      // Aquí, implementa la lógica para refrescar la UI. Esta implementación depende de tu estructura de aplicación.

      Navigator.pop(context); // Cierra el Drawer
      Navigator.pushReplacementNamed(context, '/chatScreen'); // Refresca la pantalla de chats
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              //TODO: Implementar la lógica para editar el nombre y apellido del usuario y foto de perfil
              Navigator.of(context).pop(); // Cierra el menú
            },
            child: const UserAccountsDrawerHeader(
              accountName: Text("Nombre y Apellido del Usuario"),
              accountEmail: Text(""),
              currentAccountPicture: CircleAvatar(
                child: FlutterLogo(size: 45.0),
              ),
              decoration: BoxDecoration(
                color: Color.fromRGBO(139, 0, 0, 1),
              ),
            ),
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
              _handleNewChat(context);
              restartChat(() {});
              //TODO: Implementar logica de nuevo chat.
              Navigator.of(context).pop(); // Cierra el menú
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
