import 'package:flutter/material.dart';

class CrearCita extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Nueva Cita"),
        ),
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: Container(
            child: Form(
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "Nombre",
                        hintText: "-ingresa el nombre del paciente"),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
