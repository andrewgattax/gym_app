import "package:flutter/material.dart";
import "package:my_workout/database/database_service.dart";
import "package:my_workout/models/ExType.dart";
import "package:my_workout/models/Exercise.dart";
import "package:my_workout/models/WorkoutPlan.dart";

class ExTypesProvider extends ChangeNotifier {
  List<ExType> _exTypes = [];

  ExTypesProvider() {
    /*  Exercise exTemp = Exercise(name: "LegExtension", reps: 8, sets: 3, weight: 55, exType: 3);
    aggiungiEsercizio(exTemp, 7);
    aggiungiEsercizio(exTemp, 7);
    aggiungiEsercizio(exTemp, 7);
    aggiungiEsercizio(exTemp, 7); */
    caricaExTypes();
  }

  List<ExType> get exTypes => _exTypes;

  Future<void> caricaExTypes(int workoutId) async {
    _exTypes = await DatabaseService.db.caricaExTypes(workoutId);
    notifyListeners();
  }

  Future<void> aggiungiExType(ExType ext, int wId) async {
    await DatabaseService.db.aggiungiExType(ext, wId);
    await caricaExTypes(wId);
  }

  Future<void> eliminaWorkout(ExType ext, int wId) async {
    await DatabaseService.db.eliminaExType(ext.id!);
    await caricaExTypes(wId);
  }

  Future<void> caricaEsercizi(int id) async {
    final index = _workouts.indexWhere((w) => w.id! == id);
    if (index != -1) {
      _workouts[index].exercises = await DatabaseService.db.caricaEsercizi(id);
      notifyListeners();
    }
  }

  Future<void> aggiungiEsercizio(Exercise exercise, int workoutId) async {
    await DatabaseService.db.aggiungiEsercizio(exercise, workoutId);
    await caricaWorkouts();
    notifyListeners();
  }

  Future<void> eliminaEsercizio(int id) async {
    await DatabaseService.db.eliminaEsercizio(id);
    await caricaWorkouts();
    notifyListeners();
  }

  Future<void> modificaEsercizio(Exercise ex) async {
    await DatabaseService.db.modificaEsercizio(ex);
    await caricaWorkouts();
    notifyListeners();
  }
}
