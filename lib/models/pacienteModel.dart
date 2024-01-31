class Paciente {
  String documento;
  String nombre;
  String apellidos;
  DateTime fechaDeNacimento;
  String direccion;
  String telefono;
  String correoElectronico;
  String? estado;

  Paciente(this.documento, this.nombre, this.apellidos, this.fechaDeNacimento,
      this.direccion, this.telefono, this.correoElectronico,
      [this.estado]);

  Paciente.fromMap(Map<String, dynamic> item)
      : documento = item['documento'],
        nombre = item['nombre'],
        apellidos = item['apellidos'],
        fechaDeNacimento = DateTime.parse(item['fechaDeNacimento']),
        direccion = item['direccion'],
        telefono = item['telefono'],
        correoElectronico = item['correoElectronico'],
        estado = item['estado'];

  Map<String, dynamic> toJson() => {
        'documento': documento,
        'nombre': nombre,
        'apellidos': apellidos,
        'telefono': telefono,
        'fechaDeNacimento': fechaDeNacimento.toIso8601String(),
        'direccion': direccion,
        'correoElectronico': correoElectronico,
        'estado': estado,
      };
}
