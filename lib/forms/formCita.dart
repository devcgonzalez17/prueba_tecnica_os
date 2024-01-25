import 'dart:convert';

import 'package:app_prueba_tecnica/models/medicoModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:http/http.dart' as http;

class CrearCita extends StatefulWidget {
  const CrearCita({super.key});

  @override
  CrearCitaState createState() {
    return CrearCitaState();
  }
}

class CrearCitaState extends State<CrearCita> {
  final _formKey = GlobalKey<FormState>();

  List<String> medicosNombres = <String>[];

  List<Medico> medicosList = [];
  Future<List<Medico>> getMedicos() async {
    final response =
        await http.get(Uri.parse("http://192.168.56.1:8095/osapi/medico"));
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
        medicosList.add(medico);
        medicosNombres.add("" + medico.nombre + " " + medico.apellidos);
      }
    }
    return medicosList;
  }

  String dropdownValue = "";

  TextEditingController dateInput = TextEditingController();

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
              key: _formKey,
              child: Column(
                children: [
                  FutureBuilder(
                    future: getMedicos(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                          child: DropdownMenu<Medico>(
                            initialSelection: medicosList.first,
                            onSelected: (Medico? value) {
                              // This is called when the user selects an item.
                              setState(() {
                                dropdownValue = value!.documento;
                                print(dropdownValue);
                              });
                            },
                            dropdownMenuEntries: snapshot.data!
                                .map<DropdownMenuEntry<Medico>>((Medico value) {
                              return DropdownMenuEntry<Medico>(
                                  value: value, label: value.nombre);
                            }).toList(),
                          ),
                        );
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "Documento del Medico",
                          hintText:
                              "-Ingresa el numero de documento del medico",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ]),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: "Documento del paciente",
                        hintText:
                            "-Ingresa el numero de documento del paciente",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 10.0, bottom: 10.0, right: 10.0),
                          child: TextFormField(
                            controller: dateInput,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Por favor selecciona la fecha de la cita";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: "Fecha de la cita",
                              hintText: "-Selecciona la fecha de la cita",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            readOnly: true,
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1950),
                                  //DateTime.now() - not to allow to choose before today.
                                  lastDate: DateTime(2100));

                              if (pickedDate != null) {
                                print(
                                    pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                                print(
                                    formattedDate); //formatted date output using intl package =>  2021-03-16

                                setState(() {
                                  dateInput.text = formattedDate;
                                });
                              } else {}
                            },
                          ),
                        ),
                      ),
                      Flexible(
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 10.0, bottom: 10.0, left: 10.0),
                          child: TextFormField(
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Por favor selecciona la hora de la cita";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: "Hora de la cita",
                              hintText: "-Selecciona la hora de la cita",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: "Observaciones",
                        hintText: "-Ingresa observaciones de la cita",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: "Estado de la cita",
                        hintText: "-Ingresa el nombre del paciente",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: TextFormField(
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return "Por favor selecciona la fecha de la cita";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Nombre",
                        hintText: "-Ingresa el documento del paciente",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
