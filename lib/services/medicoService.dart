import 'package:app_prueba_tecnica/models/medicoModel.dart';

abstract class MedicoService {
  Future<List<Medico>> getMedicos();
  Future<Medico> newMedico(Medico c);
  Future<Medico> getMedico(String documento);
}
