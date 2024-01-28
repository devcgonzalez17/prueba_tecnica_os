import 'package:app_prueba_tecnica/models/citaModel.dart';
import 'package:http/http.dart';

abstract class CitaService {
  Future<List<Cita>> getCitas();
  Future<Response> newCita(Cita c);
  Future<Cita> getCita(int numeroCita);
}
