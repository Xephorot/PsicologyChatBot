import 'package:chatbot_psicologia/Controllers/Chat/ProfileEdition.dart';
import 'package:flutter/material.dart';
class UserProfile extends StatelessWidget {
  const UserProfile({super.key});
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ProfileEditor.instance.profileNotifier,
      builder: (context, Profile profile, child) {
        return GestureDetector(
          onTap: () => ProfileEditor.instance.editProfile(context),
          child: UserAccountsDrawerHeader(
            accountName: Text(profile.username),
            accountEmail: const Text(""),
            currentAccountPicture: const CircleAvatar(
              child: FlutterLogo(size: 45.0),
            ),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 0, 150, 20),
            ),
          ),
        );
      },
    );
  }
}
