class Medico {
  String documento;
  String nombre;
  String apellidos;
  String telefono;
  String correoElectronico;
  String? estado;

  Medico(this.documento, this.nombre, this.apellidos, this.telefono,
      this.correoElectronico,
      [this.estado]);

  Medico.fromMap(Map<String, dynamic> item)
      : documento = item['documento'],
        nombre = item['nombre'],
        apellidos = item['apellidos'],
        telefono = item['telefono'],
        correoElectronico = item['correoElectronico'],
        estado = item['estado'];

  Map<String, dynamic> toJson() => {
        'documento': documento,
        'nombre': nombre,
        'apellidos': apellidos,
        'telefono': telefono,
        'correoElectronico': correoElectronico,
        'estado': estado,
      };
}
