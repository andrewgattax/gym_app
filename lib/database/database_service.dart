import 'dart:io';

import 'package:flutter/services.dart';
import 'package:gym_app/models/Exercise.dart';
import 'package:gym_app/models/WorkoutPlan.dart';
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
    final path = join(dbPath, 'my_workout.db');

    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE workout(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT
        );
        CREATE TABLE exercise(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          workoutId INTEGER,
          name TEXT,
          sets INTEGER,
          reps INTEGER,
          weight INTEGER,
          exType INTEGER,
          FOREIGN KEY (workoutId) REFERENCES workout(id)
        );
      ''');
    });
  }

  aggiungiWorkout(WorkoutPlan workoutPlan) async {
    final db = await database;
    db!.insert("workout", workoutPlan.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  aggiungiEsercizio(Exercise ex, int workoutId) async {
    final db = await database;
    await db!.insert(
      "exercise",
      ex.toMap()..['workoutId'] = workoutId,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
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
        for(final {
          'id' : id as int,
          'name': name as String,
        } in resultMap) WorkoutPlan(id: id, name: name, exercises: await caricaEsercizi(id))
      ];
    }
  }

  Future<List<Exercise>> caricaEsercizi (int workoutId) async {
    final db = await database;
    var res = await db!.query("exercise", where: 'workoutId = ?', whereArgs: [workoutId]);
    if(res.length == 0) {
      return [];
    } else {
      var resultMap = res.toList();
      return [
        for (final {
          'id' : id as int,
          'name': name as String,
          'reps': reps as int,
          'sets' : sets as int,
          'weight' : weight as int,
          'exType' : exType as int,
        } in resultMap) Exercise(id: id, name: name, reps: reps, sets: sets, weight: weight, exType: exType)
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


