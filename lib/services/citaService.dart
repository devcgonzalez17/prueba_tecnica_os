import 'package:app_prueba_tecnica/models/citaModel.dart';

abstract class CitaService {
  Future<List<Cita>> getCitas();
  Future<Cita> newCita(Cita c);
  Future<Cita> getCita(int numeroCita);
}
