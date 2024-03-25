import 'package:flutter/material.dart';

class Profile {
  String username;

  Profile(this.username);
}

class ProfileEditor {
  static final ProfileEditor _instance = ProfileEditor._internal();
  Profile _profile = Profile('Usuario'); // Perfil inicial

  factory ProfileEditor() {
    return _instance;
  }

  ProfileEditor._internal();

  static ProfileEditor get instance => _instance;

  void editProfile(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ProfileEditDialog(profile: _profile);
      },
    );
  }

  Profile getProfile() {
    return _profile;
  }

  void saveProfile(String newUsername) {
    _profile.username = newUsername;
    // Aquí puedes implementar la lógica para guardar el perfil
    print('Perfil guardado: ${_profile.username}');
  }
}

class ProfileEditDialog extends StatelessWidget {
  final Profile profile;
  final TextEditingController _usernameController = TextEditingController();

  ProfileEditDialog({required this.profile});

  @override
  Widget build(BuildContext context) {
    _usernameController.text = profile.username;

    return AlertDialog(
      title: Text('Editar Perfil'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _usernameController,
            decoration: InputDecoration(labelText: 'Nombre de usuario'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              ProfileEditor.instance.saveProfile(_usernameController.text);
              Navigator.of(context).pop(); // Cerrar la ventana emergente
            },
            child: Text('Guardar Cambios'),
          ),
        ],
      ),
    );
  }
}
