import 'package:gym_app/models/Exercise.dart';

class WorkoutPlan {
  int? id = null;
  String name;
  List<Exercise> exercises;

  WorkoutPlan({
    this.id,
    required this.name,
    required this.exercises,
  });

  // Method to add an exercise to the plan
  void addExercise(Exercise exercise) {
    exercises.add(exercise);
  }

  // Method to remove an exercise from the plan
  void removeExercise(Exercise exercise) {
    exercises.remove(exercise);
  }

  // Method to get the total number of exercises
  int get totalExercises => exercises.length;

  @override
  String toString() {
    return 'WorkoutPlan(name: $name, exercises: $exercises)';
  }

  Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'name': name,
    };
  }
}