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
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      labelText: "Cita #" + args.cita!.numeroCita.toString(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      labelText: "Medico: " +
                          args.cita!.documentoMedico.nombre.toString() +
                          " " +
                          args.cita!.documentoMedico.apellidos.toString(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      labelText: "Paciente: " +
                          args.cita!.documentoPaciente.nombre.toString() +
                          " " +
                          args.cita!.documentoPaciente.apellidos.toString(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: TextField(
                          enabled: false,
                          decoration: InputDecoration(
                            labelText: "Fecha: " +
                                DateFormat('yyyy-MM-dd')
                                    .format(args.cita!.fechaCita),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        child: TextField(
                          enabled: false,
                          decoration: InputDecoration(
                            labelText: "Hora: " +
                                DateFormat('H:m').format(args.cita!.horaCita),
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
                  child: TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      labelText: "Observaciones: " +
                          args.cita!.observaciones.toString(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      labelText: "Estado: " + args.cita!.estado.toString(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
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
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      labelText:
                          "Documento: " + args.medico!.documento.toString(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "Nombre: " + args.medico!.nombre.toString(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText:
                          "Apellidos: " + args.medico!.apellidos.toString(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText:
                          "Teléfono: " + args.medico!.telefono.toString(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "Correo Electronico: " +
                          args.medico!.correoElectronico.toString(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "Estado: " + args.medico!.estado.toString(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
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
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      labelText:
                          "Documento: " + args.paciente!.documento.toString(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "Nombre: " + args.paciente!.nombre.toString(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText:
                          "Apellidos: " + args.paciente!.apellidos.toString(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "Fecha de nacimiento: " +
                          DateFormat.yMMMMd('en_US')
                              .format(args.paciente!.fechaDeNacimento),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText:
                          "Dirección: " + args.paciente!.direccion.toString(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText:
                          "Teléfono: " + args.paciente!.telefono.toString(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "Correo Electronico: " +
                          args.paciente!.correoElectronico.toString(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "Estado: " + args.paciente!.estado.toString(),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
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
