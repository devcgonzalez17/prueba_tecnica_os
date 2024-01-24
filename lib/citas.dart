import 'dart:convert';
import 'dart:core';

import 'package:app_prueba_tecnica/detalles.dart';
import 'package:app_prueba_tecnica/models/citaModel.dart';
import 'package:app_prueba_tecnica/models/medicoModel.dart';
import 'package:app_prueba_tecnica/models/pacienteModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class Citas extends StatefulWidget {
  const Citas({super.key});

  @override
  CitasState createState() {
    return CitasState();
  }
}

class CitasState extends State<Citas> {
  List<Cita> citasList = [];

  Future<List<Cita>> getCitas() async {
    print("inicio de get citas");
    final response =
        await http.get(Uri.parse("http://192.168.56.1:8095/osapi/citas/all"));
    print(response.statusCode);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      //print(data);
      for (Map i in data) {
        Medico medico = Medico(
          i['documentoMedico']['documento'],
          i['documentoMedico']['nombre'],
          i['documentoMedico']['apellidos'],
          i['documentoMedico']['telefono'],
          i['documentoMedico']['correoElectronico'],
          i['documentoMedico']['estado'],
        );
        print(medico);

        print(i['documentoPaciente']);
        Paciente paciente = Paciente(
          i['documentoPaciente']['documento'],
          i['documentoPaciente']['nombre'],
          i['documentoPaciente']['apellidos'],
          DateTime.parse(i['documentoPaciente']['fechaDeNacimiento']),
          i['documentoPaciente']['direccion'],
          i['documentoPaciente']['telefono'],
          i['documentoPaciente']['correoElectronico'],
          i['documentoPaciente']['estado'],
        );
        print(paciente);
        Cita cita = Cita(
            DateTime.parse(i['fechaCita']),
            DateTime.parse(i['horaCita']),
            i['estado'],
            medico,
            paciente,
            i['numeroCita'],
            i['observaciones']);
        print(cita);
        citasList.add(cita);
        print(citasList);
      }
    }
    return citasList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Citas"),
        ),
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                  child: FutureBuilder(
                future: getCitas(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: citasList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Detalles(),
                                settings: RouteSettings(
                                    arguments: detallesArguments(
                                        cita: snapshot.data![index]))));
                          },
                          title: Text("#" +
                              snapshot.data![index].numeroCita.toString() +
                              " " +
                              DateFormat('yyyy-MM-dd H:m')
                                  .format(snapshot.data![index].horaCita)),
                          subtitle: Text("Dr." +
                              snapshot.data![index].documentoMedico.nombre
                                  .toString() +
                              snapshot.data![index].documentoMedico.apellidos
                                  .toString() +
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
