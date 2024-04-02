import 'package:flutter/material.dart';

class RosenbergTestTile extends StatelessWidget {
  const RosenbergTestTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.assessment),
      title: Text('Test de Autoestima de Rosenberg'),
      onTap: () {
        Navigator.pushNamed(context, '/rosenbergTest');
      },
    );
  }
}
