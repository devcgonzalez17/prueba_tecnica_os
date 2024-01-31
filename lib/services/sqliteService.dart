import 'package:app_prueba_tecnica/models/citaModel.dart';
import 'package:app_prueba_tecnica/models/medicoModel.dart';
import 'package:app_prueba_tecnica/models/pacienteModel.dart';
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
    try {
      Database? db = await getDB;
      Batch batch = db!.batch();
      print("json");
      print(cita.toLocalJson());
      batch.insert('Cita', cita.toLocalJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      await batch.commit(noResult: true);
      result = 200;
    } catch (e) {
      result = 400;
    }
    return result;
  }

  Future<int> createMedico(Medico medico) async {
    int result = 0;
    try {
      Database? db = await getDB;
      Batch batch = db!.batch();
      batch.insert('Medico', medico.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      await batch.commit(noResult: true);
      result = 200;
    } catch (e) {
      result = 400;
    }
    return result;
  }

  Future<int> createPaciente(Paciente paciente) async {
    int result = 0;
    try {
      Database? db = await getDB;
      Batch batch = db!.batch();
      batch.insert('Paciente', paciente.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
      await batch.commit(noResult: true);
      result = 200;
    } catch (e) {
      result = 400;
    }
    return result;
  }

  Future<List<Cita>> getCitas() async {
    Database? db = await getDB;
    final List<Map<String, dynamic>> queryResult = await db!.query("Cita");
    print(queryResult);
    List<Paciente> pacientes = await getPacientes();
    List<Medico> medicos = await getMedicos();
    return queryResult
        .map((e) => Cita.fromLocalMap(e, pacientes, medicos))
        .toList();
  }

  Future<List<Medico>> getMedicos() async {
    Database? db = await getDB;
    final List<Map<String, dynamic>> queryResult = await db!.query("Medico");
    print(queryResult);
    return queryResult.map((e) => Medico.fromMap(e)).toList();
  }

  Future<List<Paciente>> getPacientes() async {
    Database? db = await getDB;
    final List<Map<String, dynamic>> queryResult = await db!.query("Paciente");
    print(queryResult);
    return queryResult.map((e) => Paciente.fromMap(e)).toList();
  }

  Future<int?> deleteCita(int? numeroCita) async {
    Database? db = await getDB;
    return await db?.delete(
      "Cita",
      where: "numero_cita = ?",
      whereArgs: [numeroCita],
    );
  }

  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();

    return await openDatabase(
      join(path, 'pruebaTecnicaDB.db'),
      onCreate: createDB,
      version: 3,
    );
  }

  Future<void> createDB(Database database, int version) async {
    await database.execute("""   
          
CREATE TABLE IF NOT EXISTS 'Medico' (
    'documento' VARCHAR(16) PRIMARY KEY NOT NULL,
    'nombre' VARCHAR(60) NOT NULL,
    'apellidos' VARCHAR(60) NOT NULL,
    'telefono' VARCHAR(10) NOT NULL, 
    'correoElectronico' VARCHAR(60) NOT NULL UNIQUE,
    'estado' VARCHAR(12) NULL
);
""");
    await database.execute("""
CREATE TABLE IF NOT EXISTS 'Paciente'(
    'documento' VARCHAR(16) PRIMARY KEY NOT NULL,
    'nombre' VARCHAR(60) NOT NULL,
    'apellidos' VARCHAR(60) NOT NULL,
    'fechaDeNacimento' DATE NOT NULL,
    'direccion' VARCHAR(60) NULL,
    'telefono' VARCHAR(10) NOT NULL,
    'correoElectronico' VARCHAR(60) NOT NULL UNIQUE,
    'estado' VARCHAR(12) NULL
);
""");
    await database.execute(
      """
CREATE TABLE IF NOT EXISTS 'Cita'(
    'numero_cita' INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    'documento_medico' VARCHAR(60) NOT NULL,
    'documento_paciente' VARCHAR(60) NOT NULL,
    'fechaCita' DATE NOT NULL,
    'horaCita' DATETIME NOT NULL,
    'observaciones' TEXT NULL,
    'estado' VARCHAR(12) NULL,
    FOREIGN KEY('documento_medico') REFERENCES 'medico'('documento'),
    FOREIGN KEY('documento_paciente') REFERENCES 'paciente'('documento')
);
          
          """,
    );
  }
}
