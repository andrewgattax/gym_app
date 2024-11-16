import "package:flutter/material.dart";
import "package:my_workout/database/database_service.dart";
import "package:my_workout/models/Exercise.dart";
import "package:my_workout/models/WorkoutPlan.dart";

class WorkoutProvider extends ChangeNotifier{
  List<WorkoutPlan> _workouts = [];

  WorkoutProvider() {
   /*  Exercise exTemp = Exercise(name: "LegExtension", reps: 8, sets: 3, weight: 55, exType: 3);
    aggiungiEsercizio(exTemp, 7);
    aggiungiEsercizio(exTemp, 7);
    aggiungiEsercizio(exTemp, 7);
    aggiungiEsercizio(exTemp, 7); */
    caricaWorkouts();
  }

  List<WorkoutPlan> get workouts => _workouts;

  Future<void> caricaWorkouts() async {
    _workouts = await DatabaseService.db.caricaWorkouts();
    notifyListeners();
  }

  Future<void> aggiungiWorkout(WorkoutPlan w) async {
    await DatabaseService.db.aggiungiWorkout(w);
    await caricaWorkouts();
  }

  Future<void> eliminaWorkout(WorkoutPlan w) async {
    await DatabaseService.db.eliminaWorkout(w.id!);
    await caricaWorkouts();
  }

  Future<void> caricaEsercizi(int id) async {
    final index = _workouts.indexWhere((w) => w.id! == id);
    if(index != -1) {
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