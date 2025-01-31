import 'package:my_workout/models/ExType.dart';
import 'package:my_workout/models/Exercise.dart';

class WorkoutPlan {
  int? id = null;
  String name;
  List<ExType> exTypes;

  WorkoutPlan({
    this.id,
    required this.name,
    required this.exTypes,
  });

  // Method to add an exercise to the plan
  void addExType(ExType exType) {
    exTypes.add(exType);
  }

  // Method to remove an exercise from the plan
  void removeExercise(ExType exType) {
    exTypes.remove(exType);
  }

  // Method to get the total number of exercises
  int get totalExTypes => exTypes.length;

  int get totalExercises =>
      exTypes.fold(0, (sum, exType) => sum + exType.exercises.length);

  @override
  String toString() {
    return 'WorkoutPlan(name: $name, exTypes: $exTypes)';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }
}
