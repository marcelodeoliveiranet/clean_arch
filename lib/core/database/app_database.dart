import 'package:clean_arch/core/database/tables/cliente.dart';
import 'package:clean_arch/core/database/tables/ramo_atividade.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  static Database? _database;
  static const _dbName = "app_database.db";
  static const _dbVersion = 6;

  AppDatabase._();

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  static Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);
    return openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreate,
      onUpgrade: _update,
      onConfigure: (db) async {
        await db.execute("PRAGMA foreign_keys = ON");
      },
    );
  }

  static Future<void> _onCreate(Database db, int version) async {
    await db.execute(clienteTable);
    await db.execute(ramoAtividadeTable);
  }

  static Future<void> _update(
    Database db,
    int old_version,
    int new_version,
  ) async {
    print(old_version);
    print(new_version);

    if (old_version < 6) {
      await db.execute(clienteTable);
    }
  }
}
