/* import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:gym_app/database/database_service.dart';
import 'package:gym_app/database/exercises_db.dart';
import 'package:gym_app/models/WorkoutPlan.dart';

class WorkoutsDb {
  final tableName = "workout";

  Future<void> createTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $tableName(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT
      )
    ''');
    print("fatta la table");
  }

  Future<int> insertWorkout(WorkoutPlan workoutPlan) async {
    final db = await DatabaseService().database;
    return await db!.rawInsert('INSERT INTO $tableName(name) VALUES(?)', [workoutPlan.name]);
  }

  Future<List<WorkoutPlan>> getWorkouts() async {
    final db = await DatabaseService().database;
    final List<Map<String, dynamic>> maps = await db!.query(tableName);

    return Future.wait(maps.map((map) async {
      final exercises = await ExercisesDb().getExercisesFromWorkout(map['id']);
      return WorkoutPlan(
        name: map['name'],
        exercises: exercises,
      );
    }).toList());
  }
} */