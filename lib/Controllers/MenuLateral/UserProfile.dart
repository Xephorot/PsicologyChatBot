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
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset(
                  'android/assets/images/psicoapp logo.jpg',
                  fit: BoxFit.cover,
                  width: 90.0,
                  height: 90.0,
                ),
              ),
            ),
            decoration: const BoxDecoration(
              color: Colors.green,
            ),
          ),
        );
      },
    );
  }
}
