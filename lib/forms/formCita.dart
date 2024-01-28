import 'package:app_prueba_tecnica/main.dart';
import 'package:app_prueba_tecnica/models/citaModel.dart';
import 'package:app_prueba_tecnica/models/medicoModel.dart';
import 'package:app_prueba_tecnica/models/pacienteModel.dart';
import 'package:app_prueba_tecnica/services/citaServiceImpl.dart';
import 'package:app_prueba_tecnica/services/medicoServiceImpl.dart';
import 'package:app_prueba_tecnica/services/pacienteServiceImpl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class formCitaArguments {
  final Cita? cita;

  formCitaArguments([this.cita]);
}

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
    medicosList = await medicoServiceImpl().getMedicos();
    if (dropdownMedicoValue == null) {
      dropdownMedicoValue = medicosList.first;
    }

    return medicosList;
  }

  List<Paciente> pacientesList = [];
  Future<List<Paciente>> getPacientes() async {
    pacientesList = await pacienteServiceImpl().getPacientes();
    if (dropdownPacienteValue == null) {
      dropdownPacienteValue = pacientesList.first;
    }
    return pacientesList;
  }

  List<DateTime> horas = [DateTime.now()];
  List<String> estados = ["Ocupado", "Disponible", "Rechazada", "Cancelada"];

  Medico? dropdownMedicoValue;
  Paciente? dropdownPacienteValue;
  late DateTime? dropdownHoraValue;
  late String? dropdownEstadoValue;

  TextEditingController dateInput = TextEditingController();
  TextEditingController observaciones = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as formCitaArguments?;
    print(args);

    if (args != null && args.cita != null) {
      dropdownMedicoValue = args.cita?.documentoMedico;
      dropdownPacienteValue = args.cita?.documentoPaciente;
      dropdownHoraValue = args.cita?.horaCita;
      dropdownEstadoValue = args.cita?.estado;
      dateInput.text = args.cita!.fechaCita.toString();
      observaciones.text = args.cita!.observaciones.toString();
    }
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
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          width: double.maxFinite,
                          child: DropdownMenu<Medico>(
                            label: Text("Medico"),
                            width: 370.0,
                            initialSelection: dropdownMedicoValue,
                            onSelected: (Medico? value) {
                              // This is called when the user selects an item.
                              setState(() {
                                dropdownMedicoValue = value!;
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
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                  FutureBuilder(
                    future: getPacientes(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          width: double.maxFinite,
                          child: DropdownMenu<Paciente>(
                            label: Text("Paciente"),
                            width: 370.0,
                            initialSelection: dropdownPacienteValue,
                            onSelected: (Paciente? value) {
                              // This is called when the user selects an item.
                              setState(() {
                                dropdownPacienteValue = value!;
                              });
                            },
                            dropdownMenuEntries: snapshot.data!
                                .map<DropdownMenuEntry<Paciente>>(
                                    (Paciente value) {
                              return DropdownMenuEntry<Paciente>(
                                  value: value, label: value.nombre);
                            }).toList(),
                          ),
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
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
                                initialDate: DateTime(
                                    DateTime.now().year,
                                    DateTime.now().month,
                                    DateTime.now().day + 1),
                                firstDate: DateTime(
                                    DateTime.now().year,
                                    DateTime.now().month,
                                    DateTime.now().day + 1),
                                //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime(
                                    DateTime.now().year,
                                    DateTime.now().month + 1,
                                    DateTime.now().day + 1),
                              );

                              if (pickedDate != null) {
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                                setState(() {
                                  dateInput.text = formattedDate;

                                  buildHoras(formattedDate);
                                });
                              } else {}
                            },
                          ),
                        ),
                      ),
                      Flexible(
                        child: DropdownMenu<DateTime>(
                          label: Text("Selecciona la hora"),
                          initialSelection: horas.first,
                          onSelected: (DateTime? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              dropdownHoraValue = value!;
                            });
                          },
                          dropdownMenuEntries: horas
                              .map<DropdownMenuEntry<DateTime>>(
                                  (DateTime value) {
                            return DropdownMenuEntry<DateTime>(
                                value: value,
                                label: DateFormat('H:mm').format(value));
                          }).toList(),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: TextFormField(
                      controller: observaciones,
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
                    child: DropdownMenu<String>(
                      label: Text("Estado"),
                      width: 370.0,
                      initialSelection: estados.first,
                      onSelected: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          dropdownEstadoValue = value!;
                        });
                      },
                      dropdownMenuEntries: estados
                          .map<DropdownMenuEntry<String>>((String value) {
                        return DropdownMenuEntry<String>(
                            value: value, label: value);
                      }).toList(),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Guardando Información')),
                        );
                        Cita cita = buildCita();
                        Response response =
                            await citaServiceImpl().newCita(cita);

                        if (response.statusCode == 200) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Guardado correctamente')),
                          );
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => Home()));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                                    "Ha ocurrido un error: ${response.body.split("Where")[0]}")),
                          );
                        }
                      }
                    },
                    child: const Text('Guardar'),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  buildHoras(String fecha) {
    DateTime dateFecha = DateTime.parse(fecha);
    horas = [DateTime.now()];
    for (int i = 8; i < 19; i++) {
      DateTime hora = DateTime(
          int.parse(DateFormat('yyyy').format(dateFecha)),
          int.parse(DateFormat('MM').format(dateFecha)),
          int.parse(DateFormat('dd').format(dateFecha)),
          i);
      horas.add(hora);
    }
  }

  Cita buildCita() {
    Cita cita = Cita(
      DateTime.parse(dateInput.text),
      dropdownHoraValue!,
      dropdownEstadoValue!,
      dropdownMedicoValue!,
      dropdownPacienteValue!,
      0,
      observaciones.text,
    );
    print(cita);
    return cita;
  }
}
