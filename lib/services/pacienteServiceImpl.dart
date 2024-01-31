import 'dart:convert';

import 'package:app_prueba_tecnica/models/pacienteModel.dart';
import 'package:app_prueba_tecnica/services/pacienteService.dart';
import 'package:app_prueba_tecnica/services/sqliteService.dart';
import 'package:http/http.dart' as http;

class pacienteServiceImpl extends PacienteService {
  final uriBase = "http://192.168.56.1:8095/osapi";

  @override
  Future<Paciente> getPaciente(String documento) async {
    late Paciente paciente;
    final response =
        await http.get(Uri.parse("$uriBase/paciente/$documento")).timeout(
      const Duration(seconds: 10),
      onTimeout: () {
        // Time has run out, do what you wanted to do.
        return http.Response(
            'Error', 408); // Request Timeout response status code
      },
    );
    if (response.statusCode == 200) {
      var i = jsonDecode(response.body.toString());
      paciente = Paciente(
        i['documento'],
        i['nombre'],
        i['apellidos'],
        DateTime.parse(i['fechaDeNacimiento']),
        i['direccion'],
        i['telefono'],
        i['correoElectronico'],
        i['estado'],
      );
    }
    return paciente;
  }

  @override
  Future<List<Paciente>> getPacientes() async {
    List<Paciente> pacientesList = [];
    final response = await http.get(Uri.parse("$uriBase/paciente")).timeout(
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
        Paciente paciente = Paciente(
          i['documento'],
          i['nombre'],
          i['apellidos'],
          DateTime.parse(i['fechaDeNacimiento']),
          i['direccion'],
          i['telefono'],
          i['correoElectronico'],
          i['estado'],
        );
        pacientesList.add(paciente);
        SqliteService().createPaciente(paciente);
      }
    }
    return pacientesList;
  }

  @override
  Future<Paciente> newPaciente(Paciente c) async {
    late Paciente paciente;
    final response = await http.post(
      Uri.parse("$uriBase/paciente/create"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<Paciente>{c}),
    );
    if (response.statusCode == 200) {
      var i = jsonDecode(response.body.toString());
      paciente = Paciente(
        i['documento'],
        i['nombre'],
        i['apellidos'],
        DateTime.parse(i['fechaDeNacimiento']),
        i['direccion'],
        i['telefono'],
        i['correoElectronico'],
        i['estado'],
      );
    }
    return paciente;
  }
}
