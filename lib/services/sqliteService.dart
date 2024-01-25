import 'package:app_prueba_tecnica/models/citaModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqliteService {
  Future<int> createCita(Cita cita) async {
    int result = 0;
    final Database db = await initializeDB();
    final numeroCita = await db.insert('cita', cita.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return result;
  }

    Future<List<Cita>> getCitas() async {
    final db = await initializeDB();
    final List<Map<String, Object?>> queryResult = 
      await db.query('cita');
    return queryResult.map((e) => Cita.fromMap(e)).toList();
  }

  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();

    return openDatabase(
      join(path, 'database.db'),
      onCreate: (database, version) async {
        await database.execute(
          """   
          
CREATE TABLE IF NOT EXISTS medico(
    documento VARCHAR(16) NOT NULL,
    nombre VARCHAR(60) NOT NULL,
    apellidos VARCHAR(60) NOT NULL,
    telefono INTEGER NOT NULL, 
    correo_electronico citext NOT NULL CHECK(correo_electronico ~ '^[\w\-\.]+@([\w\-]+\.)+[\w\-]{2,4}') UNIQUE,
    estado VARCHAR(12) NULL,
    PRIMARY KEY(documento),
    UNIQUE(documento, correo_electronico)
);

CREATE TABLE IF NOT EXISTS paciente(
    documento VARCHAR(16) NOT NULL,
    nombre VARCHAR(60) NOT NULL,
    apellidos VARCHAR(60) NOT NULL,
    fecha_de_nacimiento DATE NOT NULL,
    direccion VARCHAR(60) NULL,
    telefono INTEGER NOT NULL,
    correo_electronico citext NOT NULL CHECK(correo_electronico ~ '^[\w\-\.]+@([\w\-]+\.)+[\w\-]{2,4}') UNIQUE,
    estado VARCHAR(12) NULL,
    PRIMARY KEY(documento),
    UNIQUE(documento, correo_electronico)
);

CREATE TABLE IF NOT EXISTS cita (
    numero_cita SERIAL PRIMARY KEY,
    documento_medico VARCHAR(60) NOT NULL,
    documento_paciente VARCHAR(60) NOT NULL,
    fecha_cita DATE NOT NULL,
    hora_cita TIMESTAMP NOT NULL,
    observaciones TEXT NULL,
    estado VARCHAR(12) NULL,
    FOREIGN KEY(documento_medico) REFERENCES medico(documento),
    FOREIGN KEY(documento_paciente) REFERENCES paciente(documento),
    UNIQUE(fecha_cita, hora_cita)
);
          
          """,
        );
      },
      version: 1,
    );
  }
}
