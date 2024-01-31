import 'package:app_prueba_tecnica/models/medicoModel.dart';
import 'package:http/http.dart';

abstract class MedicoService {
  Future<List<Medico>> getMedicos();
  Future<Response> newMedico(Medico c);
  Future<Medico> getMedico(String documento);
}
