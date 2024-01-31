import 'dart:convert';

import 'package:app_prueba_tecnica/models/citaModel.dart';
import 'package:app_prueba_tecnica/models/medicoModel.dart';
import 'package:app_prueba_tecnica/models/pacienteModel.dart';
import 'package:app_prueba_tecnica/services/citaService.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class citaServiceImpl extends CitaService {
  final uriBase = "http://192.168.56.1:8095/osapi";

  @override
  Future<Cita> getCita(int numeroCita) async {
    late Cita cita;
    final response =
        await http.get(Uri.parse("$uriBase/citas/$numeroCita")).timeout(
      const Duration(seconds: 10),
      onTimeout: () {
        // Time has run out, do what you wanted to do.
        return http.Response(
            'Error', 408); // Request Timeout response status code
      },
    );
    if (response.statusCode == 200) {
      var i = jsonDecode(response.body.toString());
      Medico medico = Medico(
        i['documentoMedico']['documento'],
        i['documentoMedico']['nombre'],
        i['documentoMedico']['apellidos'],
        i['documentoMedico']['telefono'],
        i['documentoMedico']['correoElectronico'],
        i['documentoMedico']['estado'],
      );

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

      cita = Cita(
        DateTime.parse(i['fechaCita']),
        DateTime.parse(i['horaCita']),
        medico,
        paciente,
        i['estado'],
        i['numeroCita'],
        i['observaciones'],
      );
    }
    return cita;
  }

  @override
  Future<List<Cita>> getCitas() async {
    List<Cita> citasList = [];
    final response = await http.get(Uri.parse("$uriBase/citas/all")).timeout(
      const Duration(seconds: 10),
      onTimeout: () {
        // Time has run out, do what you wanted to do.
        return http.Response(
            'Error', 408); // Request Timeout response status code
      },
    );
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
          i['documentoMedico']['estado']!,
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
          i['documentoPaciente']['estado']!,
        );
        print(paciente);
        Cita cita = Cita(
            DateTime.parse(i['fechaCita']),
            DateTime.parse(i['horaCita']),
            medico,
            paciente,
            i['estado'],
            i['numeroCita'],
            i['observaciones']);
        print(cita);
        citasList.add(cita);
      }
    }
    return citasList;
  }

  @override
  Future<Response> newCita(Cita c) async {
    late Cita cita;
    Map<String, dynamic> citaJson = c.toJson();
    print(jsonEncode(citaJson));

    final response = await http
        .post(
      Uri.parse("$uriBase/citas/create"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(citaJson),
    )
        .timeout(
      const Duration(seconds: 10),
      onTimeout: () {
        // Time has run out, do what you wanted to do.
        return http.Response(
            'Error', 408); // Request Timeout response status code
      },
    );
    if (response.statusCode != 200) {
      print(response.body);
    } else {
      print(response.body);
    }
    return response;
  }
}
