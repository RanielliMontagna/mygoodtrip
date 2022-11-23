import 'dart:io';

import 'package:mygoodtrip/services/database_service/scripts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static Database? _database;

  //Faz o get do banco de dados
  static Future<Database> get datebase async {
    _database ??= await initializeDatabase();
    return _database!;
  }

  static Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();

    int databaseVersion = 1;
    String path = "${directory.path}/mygoodtrip.db";

    try {
      databaseVersion = DatabaseScripts.update.entries.last.key;
    } catch (err) {
      databaseVersion = 1;
    }

    Database database = await openDatabase(
      path,
      version: databaseVersion,
      onCreate: _createdb,
      onConfigure: _onConfigure,
      onUpgrade: _onUpgrade,
    );
    // ignore: avoid_print
    print('PATH do banco: $path');

    return database;
  }

  static void _createdb(Database db, int newVersion) async {
    for (int i = 0; i < DatabaseScripts.create.length; i++) {
      await db.execute(DatabaseScripts.create[i]);
    }
  }

  static Future _onConfigure(Database db) async {
    await db.execute(
      'PRAGMA foreign_keys = ON',
    );
  }

  static void _onUpgrade(Database db, int oldVersion, int newVersion) async {
    ///Executa os scripts de update independente de versão que estava
    for (int version = oldVersion + 1; version <= newVersion; version++) {
      if (DatabaseScripts.update[version] != null) {
        for (int i = 0; i < DatabaseScripts.update[version]!.length; i++) {
          await db.execute(DatabaseScripts.update[version]![i]);
        }
      }
    }
  }

  static Future<void> deleteAllData() async {
    Database? db = await datebase;
    Batch batch = db.batch();

    List tables = await db.rawQuery(
        "SELECT name FROM sqlite_master WHERE type ='table' AND name NOT LIKE 'sqlite_%';");

    for (Map item in tables) {
      batch.execute("DELETE FROM ${item['name']}");
    }

    await batch.commit();
  }
}
