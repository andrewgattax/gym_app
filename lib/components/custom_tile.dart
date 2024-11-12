import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gym_app/models/WorkoutPlan.dart';

class CustomTile extends StatelessWidget {
  final WorkoutPlan workoutPlan;
  const CustomTile({required this.workoutPlan});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.fitness_center_rounded),
        title: Text(workoutPlan.name),
        subtitle: Text('Total exercises: ${workoutPlan.exercises.length}'),
      ),
    );
  }
}