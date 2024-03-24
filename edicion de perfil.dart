import 'package:flutter/material.dart';

void main() {
  runApp(ProfileEditScreen());
}

class ProfileEditScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Editar Perfil'),
        ),
        body: ProfileEditForm(),
      ),
    );
  }
}

class ProfileEditForm extends StatefulWidget {
  @override
  _ProfileEditFormState createState() => _ProfileEditFormState();
}

class _ProfileEditFormState extends State<ProfileEditForm> {
  String _username = 'Usuario';
  // Aquí puedes definir una variable para almacenar la ruta de la imagen de perfil
  String _profileImagePath = 'assets/default_profile_image.jpg';

  TextEditingController _usernameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _usernameController.text = _username;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Campo de edición para el nombre de usuario
          TextFormField(
            controller: _usernameController,
            decoration: InputDecoration(labelText: 'Nombre de usuario'),
            onChanged: (value) {
              setState(() {
                _username = value;
              });
            },
          ),
          SizedBox(height: 16.0),
          // Widget para mostrar la foto de perfil actual
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage(_profileImagePath),
          ),
          SizedBox(height: 16.0),
          // Botón para seleccionar una nueva imagen de perfil
          ElevatedButton(
            onPressed: () {
              // Aquí puedes agregar la lógica para seleccionar una nueva imagen de perfil
              // por ejemplo, usando un selector de imágenes o cámara.
              print('Seleccionar nueva imagen de perfil');
            },
            child: Text('Cambiar Foto de Perfil'),
          ),
          SizedBox(height: 32.0),
          // Botón para guardar los cambios
          ElevatedButton(
            onPressed: () {
              // Aquí puedes agregar la lógica para guardar los cambios del perfil
              // por ejemplo, actualizando los datos en la base de datos.
              print('Nombre de usuario: $_username');
              print('Ruta de la imagen de perfil: $_profileImagePath');
            },
            child: Text('Guardar Cambios'),
          ),
        ],
      ),
    );
  }
}
