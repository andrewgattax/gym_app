import 'package:flutter/material.dart';
import 'package:gym_app/components/add_workout_dialog.dart';
import 'package:gym_app/database/database_service.dart';
import 'package:gym_app/models/Exercise.dart';
import 'package:gym_app/models/WorkoutPlan.dart';

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
    Future.delayed(Duration.zero, () {
      setState(() {
        caricaWorkouts();
      });
    },); 
    /* Exercise newEx = Exercise(name: "Leg Ext", reps: 8, sets: 3, weight: 55); */  
  }


  Future<List<WorkoutPlan>> caricaWorkouts() async{
    final workouts = DatabaseService.db.caricaWorkouts();
    return workouts;     
  }

  void aggiungiWorkout(String workoutName) {
    setState(() {
      final workout = WorkoutPlan(name: workoutName, exercises: []);
      DatabaseService.db.aggiungiWorkout(workout).then((value) {
      caricaWorkouts();
    });
    }); 
  }

  void eliminaWorkout(int id) {
    setState(() {
        DatabaseService.db.eliminaWorkout(id);
        caricaWorkouts();
    });
  }

  void mostraAggiungiWorkout() {
    showDialog(context: context, builder: (BuildContext context) {
      return AddWorkoutDialog(onAdd: aggiungiWorkout);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        iconTheme: Theme.of(context).iconTheme,
        centerTitle: true,
        title: Text('Workout Plans', style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black
        ),
        ),
      ),
      body: Column(
        children: [Expanded(
          child: FutureBuilder(
            future: caricaWorkouts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                final workouts = snapshot.data;
                return ListView.builder(itemCount: workouts!.length,
                itemBuilder: (context, index) {
                  return WorkoutTile(
                    wp: workouts[index],
                    onDelete: () {
                      eliminaWorkout(workouts[index].id!);
                    },
                  );
                });
              }
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: ElevatedButton.icon(onPressed: () {
            mostraAggiungiWorkout();
          }, label: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 10),
            child: Text("Add new plan", style: TextStyle(
              fontWeight: FontWeight.bold
            ),),
          ),
          icon: Icon(Icons.add),)
        )
        ]
      ),
    );
      
  }
}