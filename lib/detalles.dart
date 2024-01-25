import 'package:app_prueba_tecnica/models/citaModel.dart';
import 'package:app_prueba_tecnica/models/medicoModel.dart';
import 'package:app_prueba_tecnica/models/pacienteModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class detallesArguments {
  final Medico? medico;
  final Paciente? paciente;
  final Cita? cita;

  detallesArguments({this.cita, this.medico, this.paciente});
}

class Detalles extends StatelessWidget {
  const Detalles({super.key});

  static const routeName = '/detalles';

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as detallesArguments;
    print(args);

    if (args.cita != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('')),
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: Container(
            child: Column(
              children: [
                Container(
                  width: double.maxFinite,
                  margin: const EdgeInsets.all(15.0),
                  padding: const EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueAccent),
                  ),
                  //padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Center(
                      child: Text(
                    "Cita #" + args.cita!.numeroCita.toString(),
                    style: TextStyle(fontSize: 20),
                  )),
                ),
                Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  margin: EdgeInsets.symmetric(vertical: 15.0),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromARGB(255, 111, 1, 1),
                      ),
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Text(
                    "Medico: " +
                        args.cita!.documentoMedico.nombre.toString() +
                        " " +
                        args.cita!.documentoMedico.apellidos.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
                Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  margin: EdgeInsets.symmetric(vertical: 15.0),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromARGB(255, 111, 1, 1),
                      ),
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Text(
                    "Paciente: " +
                        args.cita!.documentoPaciente.nombre.toString() +
                        " " +
                        args.cita!.documentoPaciente.apellidos.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                        child: Container(
                      width: double.maxFinite,
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                      margin: EdgeInsets.only(top: 15, bottom: 15, right: 5),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Color.fromARGB(255, 111, 1, 1),
                          ),
                          borderRadius: BorderRadius.circular(8.0)),
                      child: Text(
                        "Fecha: " +
                            DateFormat('yyyy-MM-dd')
                                .format(args.cita!.fechaCita),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    )),
                    Flexible(
                      child: Container(
                        width: double.maxFinite,
                        padding: EdgeInsets.symmetric(vertical: 15.0),
                        margin: EdgeInsets.only(top: 15, bottom: 15, left: 5),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Color.fromARGB(255, 111, 1, 1),
                            ),
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Text(
                          "Hora: " +
                              DateFormat('H:mm').format(args.cita!.horaCita),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  margin: EdgeInsets.symmetric(vertical: 15.0),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromARGB(255, 111, 1, 1),
                      ),
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Text(
                    "Observaciones: " + args.cita!.observaciones.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
                Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  margin: EdgeInsets.symmetric(vertical: 15.0),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromARGB(255, 111, 1, 1),
                      ),
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Text(
                    "Estado: " + args.cita!.estado.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      );
    } else if (args.medico != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('')),
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: Container(
            child: Column(
              children: [
                Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  margin: EdgeInsets.symmetric(vertical: 15.0),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromARGB(255, 111, 79, 238),
                      ),
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Text(
                    "Documento: " + args.medico!.documento.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
                Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  margin: EdgeInsets.symmetric(vertical: 15.0),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromARGB(255, 111, 79, 238),
                      ),
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Text(
                    "Nombre: " + args.medico!.nombre.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
                Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  margin: EdgeInsets.symmetric(vertical: 15.0),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromARGB(255, 111, 79, 238),
                      ),
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Text(
                    "Apellidos: " + args.medico!.apellidos.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
                Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  margin: EdgeInsets.symmetric(vertical: 15.0),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromARGB(255, 111, 79, 238),
                      ),
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Text(
                    "Teléfono: " + args.medico!.telefono.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
                Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  margin: EdgeInsets.symmetric(vertical: 15.0),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromARGB(255, 111, 79, 238),
                      ),
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Text(
                    "Correo Electronico: " +
                        args.medico!.correoElectronico.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
                Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  margin: EdgeInsets.symmetric(vertical: 15.0),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromARGB(255, 111, 79, 238),
                      ),
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Text(
                    "Estado: " + args.medico!.estado.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                  },
                  child: const Text('Editar'),
                ),
              ],
            ),
          ),
        ),
      );
    } else if (args.paciente != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('')),
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: Container(
            child: Column(
              children: [
                Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  margin: EdgeInsets.symmetric(vertical: 15.0),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromARGB(255, 5, 111, 1),
                      ),
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Text(
                    "Documento: " + args.paciente!.documento.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
                Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  margin: EdgeInsets.symmetric(vertical: 15.0),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromARGB(255, 5, 111, 1),
                      ),
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Text(
                    "Nombre: " + args.paciente!.nombre.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
                Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  margin: EdgeInsets.symmetric(vertical: 15.0),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromARGB(255, 5, 111, 1),
                      ),
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Text(
                    "Apellidos: " + args.paciente!.apellidos.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
                Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  margin: EdgeInsets.symmetric(vertical: 15.0),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromARGB(255, 5, 111, 1),
                      ),
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Text(
                    "Fecha de nacimiento: " +
                        DateFormat.yMMMMd('en_US')
                            .format(args.paciente!.fechaDeNacimento),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
                Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  margin: EdgeInsets.symmetric(vertical: 15.0),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromARGB(255, 5, 111, 1),
                      ),
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Text(
                    "Dirección: " + args.paciente!.direccion.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
                Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  margin: EdgeInsets.symmetric(vertical: 15.0),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromARGB(255, 5, 111, 1),
                      ),
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Text(
                    "Teléfono: " + args.paciente!.telefono.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
                Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  margin: EdgeInsets.symmetric(vertical: 15.0),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromARGB(255, 5, 111, 1),
                      ),
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Text(
                    "Correo Electronico: " +
                        args.paciente!.correoElectronico.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
                Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  margin: EdgeInsets.symmetric(vertical: 15.0),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromARGB(255, 5, 111, 1),
                      ),
                      borderRadius: BorderRadius.circular(8.0)),
                  child: Text(
                    "Estado: " + args.paciente!.estado.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                  },
                  child: const Text('Editar'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('')),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Container(
          child: Column(
            children: [
              Expanded(
                  child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text("NO TE ESPERABAMOS AQUI"),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
