import 'package:app_prueba_tecnica/models/pacienteModel.dart';
import 'package:http/http.dart';

abstract class PacienteService {
  Future<List<Paciente>> getPacientes();
  Future<Response> newPaciente(Paciente c);
  Future<Paciente> getPaciente(String documento);
}
