import 'package:flutter/material.dart';
import 'package:my_workout/components/add_workout_dialog.dart';
import 'package:my_workout/database/database_service.dart';
import 'package:my_workout/models/Exercise.dart';
import 'package:my_workout/models/WorkoutPlan.dart';
import 'package:my_workout/providers/workout_provider.dart';
import 'package:provider/provider.dart';

import '../components/workout_tile.dart';

class WorkoutsPage extends StatefulWidget {
  const WorkoutsPage({super.key});

  @override
  State<WorkoutsPage> createState() => _WorkoutsPageState();
}

class _WorkoutsPageState extends State<WorkoutsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /* Exercise newEx = Exercise(name: "Leg Ext", reps: 8, sets: 3, weight: 55); */
  }

  void mostraAggiungiWorkout() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AddWorkoutDialog(onAdd: aggiungiWorkout);
        });
  }

  void aggiungiWorkout(String workoutName) async {
    final WorkoutPlan wp = WorkoutPlan(name: workoutName, exTypes: []);
    await Provider.of<WorkoutProvider>(context, listen: false)
        .aggiungiWorkout(wp);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        iconTheme: Theme.of(context).iconTheme,
        centerTitle: true,
        title: Text(
          'Workout Plans',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: Consumer<WorkoutProvider>(builder: (context, provider, child) {
        final workouts = provider.workouts;

        return Column(children: [
          Expanded(
              child: ListView.builder(
                  itemCount: workouts!.length,
                  itemBuilder: (context, index) {
                    return WorkoutTile(
                      wp: workouts[index],
                      onDelete: () async {
                        await Provider.of<WorkoutProvider>(context,
                                listen: false)
                            .eliminaWorkout(workouts[index]);
                      },
                    );
                  })),
          Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  mostraAggiungiWorkout();
                },
                label: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 70, vertical: 10),
                  child: Text(
                    "New Workout",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                icon: Icon(Icons.add),
              ))
        ]);
      }),
    );
  }
}
