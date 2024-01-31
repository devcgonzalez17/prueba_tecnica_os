import 'package:app_prueba_tecnica/models/medicoModel.dart';
import 'package:http/http.dart' as http;

abstract class MedicoService {
  Future<List<Medico>> getMedicos();
  Future<http.Response> newMedico(Medico c);
  Future<Medico> getMedico(String documento);
}
