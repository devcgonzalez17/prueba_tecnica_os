import 'dart:core';

import 'package:app_prueba_tecnica/models/pacienteModel.dart';
import 'package:app_prueba_tecnica/services/pacienteServiceImpl.dart';
import 'package:app_prueba_tecnica/services/sqliteService.dart';
import 'package:app_prueba_tecnica/views/detalles.dart';
import 'package:flutter/material.dart';

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
    pacientesList = await pacienteServiceImpl().getPacientes();
    pacientesList = await getLocalPacientes();
    return pacientesList;
  }

  Future<List<Paciente>> getLocalPacientes() async {
    List<Paciente> LocalPacientesList = await SqliteService().getPacientes();
    return LocalPacientesList;
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
