import 'package:app_prueba_tecnica/models/citaModel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqliteService {
  Database? _db;

  Future<Database?> get getDB async {
    _db ??= await initializeDB();
    return _db;
  }

  Future<int> createCita(Cita cita) async {
    int result = 0;
    Database? db = await getDB;
    Batch batch = db!.batch();
    batch.insert('Cita', cita.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    await batch.commit(noResult: true);
    return result;
  }

  Future<List<Cita>> getCitas() async {
    Database? db = await getDB;
    final List<Map<String, dynamic>> queryResult = await db!.query("Cita");
    print(queryResult);
    return queryResult.map((e) => Cita.fromMap(e)).toList();
  }

  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();

    return await openDatabase(
      join(path, 'pruebaT.db'),
      onCreate: createDB,
      version: 1,
    );
  }

  Future<void> createDB(Database database, int version) async {
    await database.execute("""   
          
CREATE TABLE IF NOT EXISTS 'Medico' (
    'documento' VARCHAR(16) PRIMARY KEY NOT NULL,
    'nombre' VARCHAR(60) NOT NULL,
    'apellidos' VARCHAR(60) NOT NULL,
    'telefono' VARCHAR(10) NOT NULL, 
    'correo_electronico' VARCHAR(60) NOT NULL UNIQUE,
    'estado' VARCHAR(12) NULL
);
""");
    await database.execute("""
CREATE TABLE IF NOT EXISTS 'Paciente'(
    'documento' VARCHAR(16) PRIMARY KEY NOT NULL,
    'nombre' VARCHAR(60) NOT NULL,
    'apellidos' VARCHAR(60) NOT NULL,
    'fecha_de_nacimiento' DATE NOT NULL,
    'direccion' VARCHAR(60) NULL,
    'telefono' VARCHAR(10) NOT NULL,
    'correo_electronico' VARCHAR(60) NOT NULL UNIQUE,
    'estado' VARCHAR(12) NULL
);
""");
    await database.execute(
      """
CREATE TABLE IF NOT EXISTS 'Cita'(
    'numero_cita' INTEGER PRIMARY KEY,
    'documento_medico' VARCHAR(60) NOT NULL,
    'documento_paciente' VARCHAR(60) NOT NULL,
    'fecha_cita' DATE NOT NULL,
    'hora_cita' DATETIME NOT NULL,
    'observaciones' TEXT NULL,
    'estado' VARCHAR(12) NULL,
    FOREIGN KEY('documento_medico') REFERENCES 'medico'('documento'),
    FOREIGN KEY('documento_paciente') REFERENCES 'paciente'('documento')
);
          
          """,
    );
  }
}
