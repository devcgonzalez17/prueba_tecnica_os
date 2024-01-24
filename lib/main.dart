import 'package:app_prueba_tecnica/citas.dart';
import 'package:app_prueba_tecnica/detalles.dart';
import 'package:app_prueba_tecnica/medicos.dart';
import 'package:flutter/material.dart';

import 'forms/formCita.dart';

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
      appBar: AppBar(title: const Text('Prueba Tecnica')),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'One System Medical Solutions',
            style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 40,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Citas()));
            },
            child: Text('Ver Citas', style: TextStyle(fontSize: 24.0)),
          ),
          if (true)
            ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Medicos()));
              },
              child: Text('Ver Medicos', style: TextStyle(fontSize: 24.0)),
            ),
          if (true)
            ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => CrearCita()));
              },
              child: Text('Crear Paciente', style: TextStyle(fontSize: 24.0)),
            )
        ],
      )),
    );
  }
}