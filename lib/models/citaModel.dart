import 'package:app_prueba_tecnica/models/medicoModel.dart';
import 'package:app_prueba_tecnica/models/pacienteModel.dart';

class Cita {
  int? numeroCita;
  DateTime fechaCita;
  DateTime horaCita;
  String? observaciones;
  String? estado;
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
  Cita(this.fechaCita, this.horaCita, this.documentoMedico,
      this.documentoPaciente,
      [this.estado, this.numeroCita, this.observaciones]);

  Cita.fromMap(Map<String, dynamic> item)
      : fechaCita = DateTime.parse(item['fechaCita']),
        horaCita = DateTime.parse(item['horaCita']),
        estado = item['estado'],
        documentoMedico = item['documentoMedico'],
        documentoPaciente = item['documentoPaciente'],
        numeroCita = item['numeroCita'],
        observaciones = item['observaciones'];

  Cita.fromLocalMap(
      Map<String, dynamic> item, List<Paciente> pacientes, List<Medico> medicos)
      : fechaCita = DateTime.parse(item['fechaCita']),
        horaCita = DateTime.parse(item['horaCita']),
        estado = item['estado'],
        documentoMedico = medicos
            .where(
                (medico) => medico.documento.contains(item['documento_medico']))
            .toList()[0],
        documentoPaciente = pacientes
            .where((paciente) =>
                paciente.documento.contains(item['documento_paciente']))
            .toList()[0],
        numeroCita = item['numero_cita'],
        observaciones = item['observaciones'];
  Map<String, dynamic> toJson() => {
        'fechaCita': fechaCita.toIso8601String(),
        'horaCita': horaCita.toIso8601String(),
        'observaciones': observaciones,
        'estado': estado,
        'documentoMedico': documentoMedico.toJson(),
        'documentoPaciente': documentoPaciente.toJson(),
      };
  Map<String, dynamic> toLocalJson() => {
        'fechaCita': fechaCita.toIso8601String(),
        'horaCita': horaCita.toIso8601String(),
        'observaciones': observaciones,
        'estado': estado,
        'documento_medico': documentoMedico.documento,
        'documento_paciente': documentoPaciente.documento,
      };
}
