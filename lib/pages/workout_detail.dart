import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gym_app/components/delete_exercise_dialog.dart';
import 'package:gym_app/components/exercise_tile.dart';
import 'package:gym_app/database/database_service.dart';
import 'package:gym_app/models/Exercise.dart';
import 'package:gym_app/models/WorkoutPlan.dart';

class WorkoutDetail extends StatefulWidget {
  final WorkoutPlan wp;
  const WorkoutDetail({required this.wp});

  @override
  State<WorkoutDetail> createState() => _WorkoutDetailState();
}

class _WorkoutDetailState extends State<WorkoutDetail> {
  late WorkoutPlan wp;

  void rimuoviEsercizio(Exercise ex) {
    setState(() {
          DatabaseService.db.eliminaEsercizio(ex.id!);
          wp.removeExercise(ex);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    wp = widget.wp;
    /* Exercise ex = Exercise(name: "Leg Ext", reps: 3, sets: 8, weight: 55);
    DatabaseService.db.aggiungiEsercizio(ex, 7); */
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        iconTheme: Theme.of(context).iconTheme,
        centerTitle: true,
        title: Text(wp.name, style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black
        ),
        ),
      ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: Text("Exercises", style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20
              ),),
            ),
            Expanded(
              child: ListView.builder(shrinkWrap: true, itemCount: wp.exercises.length, itemBuilder: (context, index) {
                    return ExerciseTile(onDelete: () => {rimuoviEsercizio(wp.exercises[index])}, ex: wp.exercises[index]);
                },
              ),
            ),
          ],
        ),
    );
  }
}