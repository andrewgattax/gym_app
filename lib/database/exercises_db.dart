/* import 'package:gym_app/models/Exercise.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:gym_app/database/database_service.dart';
import 'package:gym_app/models/WorkoutPlan.dart';

class ExercisesDb {
  final tableName = "exercise";

  Future<void> createTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $tableName(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        workoutId INTEGER,
        name TEXT,
        sets INTEGER,
        reps INTEGER,
        weight INTEGER,
        FOREIGN KEY (workoutId) REFERENCES workout(id)
      )
    ''');
  }

  Future<int> insertExercise(Exercise exercise, int workoutId) async {
    final db = await DatabaseService().database;
    return await db!.rawInsert('INSERT INTO $tableName(name, sets, reps, weight, workoutId) VALUES(?)', [exercise.name, exercise.sets, exercise.repetitions, exercise.weight, workoutId]);
  }

  Future<List<Exercise>> getExercisesFromWorkout(int workoutId) async {
    final db = await DatabaseService().database;
    final List<Map<String, dynamic>> maps = await db!.query(tableName, where: 'workoutId = ?', whereArgs: [workoutId]);

    return List.generate(maps.length, (index) {
      return Exercise(
        name: maps[index]['name'],
        sets: maps[index]['sets'],
        repetitions: maps[index]['reps'],
        weight: maps[index]['weight']
      );
    });
  }
} */