import 'package:flutter/material.dart';

class ProfileEditor {
  static void showProfileEditor(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ProfileEditDialog();
      },
    );
  }
}

class ProfileEditDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Editar Perfil'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: 'Nombre de usuario'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // Cerrar la ventana emergente
            },
            child: Text('Guardar Cambios'),
          ),
        ],
      ),
    );
  }
}
