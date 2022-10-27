import 'package:data/configuration/configuration_database.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DatabaseService {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDataBase(ConfigurationDatabase.nameDb);
    return _database!;
  }

  Future<Database> initDataBase(String filePath) async {
    final dbPath = await getDatabasesPath();
    final String path = join(
      dbPath,
      filePath,
    );
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );
  }

  Future _createDb(
    Database instanceDb,
    int version,
  ) async {
    await instanceDb.execute(
      ConfigurationDatabase.executeCreateMovieList(),
    );
    await instanceDb.execute(
      ConfigurationDatabase.executeCreateMovieCast(),
    );
    await instanceDb.execute(
      ConfigurationDatabase.executeCreateDateLoad(),
    );
  }
}
