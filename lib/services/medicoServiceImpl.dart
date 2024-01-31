import 'dart:convert';

import 'package:app_prueba_tecnica/models/citaModel.dart';
import 'package:app_prueba_tecnica/models/medicoModel.dart';
import 'package:app_prueba_tecnica/models/pacienteModel.dart';
import 'package:app_prueba_tecnica/services/citaService.dart';
import 'package:app_prueba_tecnica/services/medicoService.dart';
import 'package:app_prueba_tecnica/services/sqliteService.dart';
import 'package:http/http.dart' as http;

class medicoServiceImpl extends MedicoService {
  final uriBase = "http://192.168.56.1:8095/osapi";

  @override
  Future<Medico> getMedico(String documento) async {
    late Medico medico;
    final response =
        await http.get(Uri.parse("$uriBase/medico/$documento")).timeout(
      const Duration(seconds: 10),
      onTimeout: () {
        // Time has run out, do what you wanted to do.
        return http.Response(
            'Error', 408); // Request Timeout response status code
      },
    );
    if (response.statusCode == 200) {
      var i = jsonDecode(response.body.toString());
      medico = Medico(
        i['documento'],
        i['nombre'],
        i['apellidos'],
        i['telefono'],
        i['correoElectronico'],
        i['estado'],
      );
    }
    return medico;
  }

  @override
  Future<List<Medico>> getMedicos() async {
    List<Medico> medicosList = [];
    final response = await http.get(Uri.parse("$uriBase/medico")).timeout(
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
          i['documento'],
          i['nombre'],
          i['apellidos'],
          i['telefono'],
          i['correoElectronico'],
          i['estado'],
        );
        medicosList.add(medico);
        SqliteService().createMedico(medico);
      }
    }
    return medicosList;
  }

  @override
  Future<Medico> newMedico(Medico c) async {
    late Medico medico;
    final response = await http.post(
      Uri.parse("$uriBase/medico/create"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<Medico>{c}),
    );
    if (response.statusCode == 200) {
      var i = jsonDecode(response.body.toString());
      medico = Medico(
        i['documento'],
        i['nombre'],
        i['apellidos'],
        i['telefono'],
        i['correoElectronico'],
        i['estado'],
      );
    }
    return medico;
  }
}
