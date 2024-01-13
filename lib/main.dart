import 'package:flutter/material.dart';

import 'formCita.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
          child: Column(
        children: [
          Text('Hello World!'),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => CrearCita()));
            },
            child: Text('Crear Cita', style: TextStyle(fontSize: 24.0)),
          )
        ],
      )),
    );
  }
}
