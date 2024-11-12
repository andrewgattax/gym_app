import 'package:flutter/material.dart';
import 'package:gym_app/database/database_service.dart';
import 'package:gym_app/database/workouts_db.dart';
import 'package:gym_app/models/WorkoutPlan.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<WorkoutPlan>? workouts;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    aggiungiWorkout();
    caricaWorkouts();
    print("gay");
  }

  Future<List<WorkoutPlan>> caricaWorkouts() async{
    final workouts = DatabaseService.db.caricaWorkouts();
    return workouts;     
  }

  void aggiungiWorkout() {
    final workout = WorkoutPlan(name: 'Workout 1', exercises: []);
    DatabaseService.db.aggiungiWorkout(workout).then((value) {
      caricaWorkouts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('MyWorkout'),
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder(
        future: caricaWorkouts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index].name),
                );
              },
            );
          }
        },
      ),
    );
      
  }
}