import 'package:app_prueba_tecnica/models/medicoModel.dart';
import 'package:app_prueba_tecnica/models/pacienteModel.dart';

class Cita {
  int? numeroCita;
  DateTime fechaCita;
  DateTime horaCita;
  String? observaciones;
  String estado;
  Medico documentoMedico;
  Paciente documentoPaciente;
/*
  set numeroCita(int value) => _numeroCita = value;

  DateTime get fechaCita => _fechaCita;
  set fechaCita(DateTime value) => _fechaCita = value;

  DateTime get horaCita => _horaCita;
  set horaCita(DateTime value) => _horaCita = value;

  String get observaciones => _observaciones;
  set observaciones(String value) => _observaciones = value;

  String get estado => _estado;
  set estado(String value) => _estado = value;

  String get documentoMedico => _documentoMedico;
  set documentoMedico(String value) => _documentoMedico = value;

  String get documentoPaciente => _documentoPaciente;
  set documentoPaciente(String value) => _documentoPaciente = value;
*/
  Cita(this.fechaCita, this.horaCita, this.estado, this.documentoMedico,
      this.documentoPaciente,
      [this.numeroCita, this.observaciones]);

  Map<String, dynamic> toJson() => {
        'fechaCita': fechaCita.toIso8601String(),
        'horaCita': horaCita.toIso8601String(),
        'observaciones': observaciones,
        'estado': estado,
        'documentoMedico': documentoMedico.toJson(),
        'documentoPaciente': documentoPaciente.toJson(),
      };
}
