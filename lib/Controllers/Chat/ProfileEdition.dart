import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile {
  String username;

  Profile(this.username);
}

class ProfileEditor {
  static final ProfileEditor _instance = ProfileEditor._internal();
  Profile _profile;
  final profileNotifier = ValueNotifier<Profile>(Profile('Usuario'));

  factory ProfileEditor() {
    return _instance;
  }

  ProfileEditor._internal() : _profile = Profile('Usuario') {
    loadProfile();
  }

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

  void saveProfile(String newUsername) async {
    _profile.username = newUsername;
    profileNotifier.value = Profile(newUsername);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', newUsername);
  }

  Future<void> loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username') ?? 'Usuario';
    _profile = Profile(username);
    profileNotifier.value = _profile;
  }
}

class ProfileEditDialog extends StatelessWidget {
  final Profile profile;
  final TextEditingController _usernameController = TextEditingController();

  ProfileEditDialog({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    _usernameController.text = profile.username;

    return AlertDialog(
      title: const Text('Editar Perfil'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _usernameController,
            decoration: const InputDecoration(labelText: 'Nombre de usuario'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              ProfileEditor.instance.saveProfile(_usernameController.text);
              Navigator.of(context).pop();
            },
            child: const Text('GUARDAR CAMBIOS'),
          ),
        ],
      ),
    );
  }
}
