import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:my_workout/models/ExType.dart';
import 'package:my_workout/models/Exercise.dart';
import 'package:my_workout/models/WorkoutPlan.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  DatabaseService._();
  static final DatabaseService db = DatabaseService._();
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await initDb();
    return _database;
  }

  Future<Database> initDb() async {
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
      print(await getDatabasesPath());
    }

    final dbPath = await getDatabasesPath();
    print(dbPath);
    databaseFactory.deleteDatabase(dbPath);
    final path = join(dbPath, 'my_workout.db');

    return await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        print("ora lo creo");
        await db.execute('''
        CREATE TABLE workout(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT
        );
      ''');
        await db.execute('''
      CREATE TABLE exType(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      workoutId INTEGER,
      name TEXT,
      FOREIGN KEY (workoutId) REFERENCES workout(id)
      );
''');
        await db.execute('''
        CREATE TABLE exercise(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          exTypeId INTEGER,
          name TEXT,
          sets INTEGER,
          reps INTEGER,
          weight DOUBLE,
          exType INTEGER,
          FOREIGN KEY (exTypeId) REFERENCES exType(id)
        );
      ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        await db.execute('''DROP TABLE exercise''');
        await db.execute('''
        CREATE TABLE exercise(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          exTypeId INTEGER,
          name TEXT,
          sets INTEGER,
          reps INTEGER,
          weight DOUBLE,
          exType INTEGER,
          FOREIGN KEY (exTypeId) REFERENCES exType(id)
        );
      ''');
      },
    );
  }

  aggiungiWorkout(WorkoutPlan workoutPlan) async {
    final db = await database;
    db!.insert("workout", workoutPlan.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  aggiungiEsercizio(Exercise ex, int exTypeId) async {
    final db = await database;
    await db!.insert(
      "exercise",
      ex.toMap()..['exTypeId'] = exTypeId,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  aggiungiExType(ExType ext, int wId) async {
    final db = await database;
    db!.insert("exType", ext.toMap()..["workoutId"] = wId,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  modificaExType(ExType ext) async {
    final db = await database;
    await db!.update(
      "exType",
      ext.toMap(),
      where: 'id = ?',
      whereArgs: [ext.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  eliminaExType(int id) async {
    final db = await database;
    db!.delete("exType", where: 'id = ?', whereArgs: [id]);
  }

  modificaEsercizio(Exercise ex) async {
    final db = await database;
    await db!.update(
      "exercise",
      ex.toMap(),
      where: 'id = ?',
      whereArgs: [ex.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<WorkoutPlan>> caricaWorkouts() async {
    final db = await database;
    var res = await db!.query("workout");
    if (res.length == 0) {
      return [];
    } else {
      var resultMap = res.toList();
      return [
        for (final {
              'id': id as int,
              'name': name as String,
            } in resultMap)
          WorkoutPlan(id: id, name: name, exTypes: await caricaExTypes(id))
      ];
    }
  }

  Future<List<ExType>> caricaExTypes(int workoutId) async {
    final db = await database;
    var res = await db!
        .query("exType", where: "workoutId = ?", whereArgs: [workoutId]);
    if (res.length == 0) {
      return [];
    } else {
      var resultMap = res.toList();
      return [
        for (final {"id": id as int, "name": name as String} in resultMap)
          ExType(id: id, name: name, exercises: await caricaEsercizi(id))
      ];
    }
  }

  Future<List<Exercise>> caricaEsercizi(int exTypeId) async {
    final db = await database;
    var res = await db!
        .query("exercise", where: 'exTypeId = ?', whereArgs: [exTypeId]);
    if (res.length == 0) {
      return [];
    } else {
      var resultMap = res.toList();
      return [
        for (final {
              'id': id as int,
              'name': name as String,
              'reps': reps as int,
              'sets': sets as int,
              'weight': weight as double,
              'exType': exType as int,
            } in resultMap)
          Exercise(id: id, name: name, reps: reps, sets: sets, weight: weight)
      ];
    }
  }

  eliminaWorkout(int id) async {
    final db = await database;
    db!.delete("workout", where: 'id = ?', whereArgs: [id]);
  }

  eliminaEsercizio(int id) async {
    final db = await database;
    db!.delete("exercise", where: 'id = ?', whereArgs: [id]);
  }

  Future<void> loadFromFile(Database db) async {
    final sql = await rootBundle.loadString('assets/sql/data.sql');
    final statements = sql.split(';');

    for (var statement in statements) {
      if (statement.isNotEmpty) {
        await db!.execute(statement);
        print("Statement eseguito");
      }
    }
  }
}
