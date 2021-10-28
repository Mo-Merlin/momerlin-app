import 'package:momerlin/data/entities/entity.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dbconfig.dart';

abstract class DataSource {
  Database db;

  String get tableName;
  String get languageTable;

  String get tableToken;
  String get primaryKey;

  Future<void> open() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, DatabaseConfig.databaseName);
    db = await openDatabase(
      path,
      version: DatabaseConfig.databaseVersion,
      onCreate: (db, version) async {
        return _createDb(db);
      },
    );
  }

  static void _createDb(Database db) {
    DatabaseConfig.createTableQueries.forEach((createTableQuery) async {
      await db.execute(createTableQuery);
    });
  }

//Insert a record
  Future<void> insert(Entity model) async {
    await checkDatabaseConnection();
    await db.insert(
      tableName,
      model.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

// update a record
  Future<void> update(Entity model) async {
    await checkDatabaseConnection();
    await db.update(
      tableName,
      model.toMap(),
      where: 'id = 1',
    );
  }

  // Get a record
  Future<Entity> get(int id) async {
    return null;
  }

  // Get all records
  Future<List<Entity>> all() async {
    return null;
  }

  Future<void> insertLang(Entity model) async {
    await checkDatabaseConnection();

    await db.insert(
      languageTable,
      model.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

// delete a record
  Future<void> delete(int id) async {
    await checkDatabaseConnection();
    await db.delete(
      tableName,
      where: '$primaryKey = ?',
      whereArgs: [id],
    );
  }

  Future<void> deleteLang() async {
    await checkDatabaseConnection();
    await db.rawDelete('DELETE FROM $languageTable');
  }

  // delete all records
  Future<void> deleteAll() async {
    await checkDatabaseConnection();

    await db.rawDelete('DELETE FROM $tableToken');
    await db.rawDelete('DELETE FROM $tableName');
    await db.rawDelete('DELETE FROM $languageTable');
  }

  Future<void> insertToken(Entity model) async {
    await checkDatabaseConnection();
    await db.insert(
      tableToken,
      model.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // close database connection
  Future<void> close() async {
    await checkDatabaseConnection();
    await db.close();
  }

  Future<void> checkDatabaseConnection() async {
    if (db == null) {
      await open();
      // throw Exception(
      //     'No open connection to database - call .open() on the datasource to establish a connection to the database');
    }
  }
}
