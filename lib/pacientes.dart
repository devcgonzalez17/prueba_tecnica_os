import 'dart:convert';
import 'dart:core';

import 'package:app_prueba_tecnica/detalles.dart';
import 'package:app_prueba_tecnica/models/pacienteModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Pacientes extends StatefulWidget {
  const Pacientes({super.key});

  @override
  PacientesState createState() {
    return PacientesState();
  }
}

class PacientesState extends State<Pacientes> {
  List<Paciente> pacientesList = [];

  Future<List<Paciente>> getPacientes() async {
    print("inicio de get pacientes");
    final response =
        await http.get(Uri.parse("http://192.168.56.1:8095/osapi/paciente"));
    print(response.statusCode);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      //print(data);
      for (Map i in data) {
        Paciente paciente = Paciente(
          i['documento'],
          i['nombre'],
          i['apellidos'],
          DateTime.parse(i['fechaDeNacimiento']),
          i['direccion'],
          i['telefono'],
          i['correoElectronico'],
          i['estado'],
        );
        print(paciente);
        pacientesList.add(paciente);
      }
    }
    return pacientesList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Pacientes"),
        ),
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                  child: FutureBuilder(
                future: getPacientes(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: pacientesList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Detalles(),
                                settings: RouteSettings(
                                    arguments: detallesArguments(
                                        paciente: snapshot.data![index]))));
                          },
                          title: Text(
                            "" +
                                snapshot.data![index].nombre.toString() +
                                " " +
                                snapshot.data![index].apellidos.toString(),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text("CC: " +
                              snapshot.data![index].documento.toString() +
                              ""),
                        );
                      },
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              )),
            ],
          ),
        ));
  }
}
