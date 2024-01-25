class Medico {
  String documento;
  String nombre;
  String apellidos;
  int telefono;
  String correoElectronico;
  String estado;

  Medico(this.documento, this.nombre, this.apellidos, this.telefono,
      this.correoElectronico, this.estado);

  Map<String, dynamic> toJson() => {
        'documento': documento,
        'nombre': nombre,
        'apellidos': apellidos,
        'telefono': telefono,
        'correoElectronico': correoElectronico,
        'estado': estado,
      };
}
