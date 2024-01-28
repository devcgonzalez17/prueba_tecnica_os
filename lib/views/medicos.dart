import 'dart:core';

import 'package:app_prueba_tecnica/views/detalles.dart';
import 'package:app_prueba_tecnica/models/medicoModel.dart';
import 'package:app_prueba_tecnica/services/medicoServiceImpl.dart';
import 'package:flutter/material.dart';

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
    medicosList = await medicoServiceImpl().getMedicos();
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
                          title: Text(
                            "Dr(a). " +
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
