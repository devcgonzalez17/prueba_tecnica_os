import 'package:app_prueba_tecnica/models/pacienteModel.dart';

abstract class PacienteService {
  Future<List<Paciente>> getPacientes();
  Future<Paciente> newPaciente(Paciente c);
  Future<Paciente> getPaciente(String documento);
}
