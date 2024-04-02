import 'package:flutter/material.dart';

class RosenbergTestScreen extends StatefulWidget {
  const RosenbergTestScreen({Key? key}) : super(key: key);

  @override
  _RosenbergTestScreenState createState() => _RosenbergTestScreenState();
}

class _RosenbergTestScreenState extends State<RosenbergTestScreen> {
  // Aquí agregarás el código para manejar las preguntas y respuestas

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test de Autoestima de Rosenberg'),
      ),
      body: Center(
        child: Text('Aquí se mostrarán las preguntas del test.'),
        // Implementa tu lógica de UI para el test aquí
      ),
    );
  }
}
