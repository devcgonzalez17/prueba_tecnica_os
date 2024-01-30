import 'dart:core';

import 'package:app_prueba_tecnica/forms/formCita.dart';
import 'package:app_prueba_tecnica/models/citaModel.dart';
import 'package:app_prueba_tecnica/services/citaServiceImpl.dart';
import 'package:app_prueba_tecnica/services/sqliteService.dart';
import 'package:app_prueba_tecnica/views/detalles.dart';
import 'package:flutter/material.dart';
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
    citasList = await citaServiceImpl().getCitas();
    return citasList;
  }

  Future<List<Cita>> getLocalCitas() async {
    citasList = await SqliteService().getCitas();
    return citasList;
  }

  @override
  Widget build(BuildContext context) {
    var citasSqlite = getLocalCitas();
    print("citas sqllite");
    print(citasSqlite);
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
                          title: Text(
                            "#" +
                                snapshot.data![index].numeroCita.toString() +
                                " " +
                                DateFormat('yyyy-MM-dd H:mm')
                                    .format(snapshot.data![index].horaCita),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
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
              ),
            ),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => CrearCita()));
              },
              child: Text('Agregar Cita', style: TextStyle(fontSize: 24.0)),
            ),
          ],
        ),
      ),
    );
  }
}
