import 'dart:convert';
import 'dart:core';

import 'package:app_prueba_tecnica/detalles.dart';
import 'package:app_prueba_tecnica/models/medicoModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Medicos extends StatefulWidget {
  const Medicos({super.key});

  @override
  MedicosState createState() {
    return MedicosState();
  }
}

class MedicosState extends State<Medicos> {
  List<Medico> medicosList = [];

  Future<List<Medico>> getMedicos() async {
    print("inicio de get medicos");
    final response =
        await http.get(Uri.parse("http://192.168.56.1:8095/osapi/medico"));
    print(response.statusCode);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      //print(data);
      for (Map i in data) {
        Medico medico = Medico(
          i['documento'],
          i['nombre'],
          i['apellidos'],
          i['telefono'],
          i['correoElectronico'],
          i['estado'],
        );
        print(medico);
        medicosList.add(medico);
        print(medicosList);
      }
    }
    return medicosList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Medicos"),
        ),
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                  child: FutureBuilder(
                future: getMedicos(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: medicosList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Detalles(),
                                settings: RouteSettings(
                                    arguments: detallesArguments(
                                        medico: snapshot.data![index]))));
                          },
                          title: Text("Dr(a). " +
                              snapshot.data![index].nombre.toString() +
                              " " +
                              snapshot.data![index].apellidos.toString()),
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
