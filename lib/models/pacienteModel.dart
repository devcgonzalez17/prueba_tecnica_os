class Paciente {
  String documento;
  String nombre;
  String apellidos;
  DateTime fechaDeNacimento;
  String direccion;
  int telefono;
  String correoElectronico;
  String estado;

  Paciente(this.documento, this.nombre, this.apellidos, this.fechaDeNacimento,
      this.direccion, this.telefono, this.correoElectronico, this.estado);

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
