import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_workout/components/add_exercise_dialog.dart';
import 'package:my_workout/components/delete_exercise_dialog.dart';
import 'package:my_workout/components/exercise_tile.dart';
import 'package:my_workout/database/database_service.dart';
import 'package:my_workout/models/Exercise.dart';
import 'package:my_workout/models/WorkoutPlan.dart';
import 'package:my_workout/providers/workout_provider.dart';
import 'package:provider/provider.dart';

class WorkoutDetail extends StatefulWidget {
  final WorkoutPlan wp;
  const WorkoutDetail({required this.wp});

  @override
  State<WorkoutDetail> createState() => _WorkoutDetailState();
}

class _WorkoutDetailState extends State<WorkoutDetail> {
  late WorkoutPlan wp;
  int _selectedIndex = 0;

  void selectIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void mostraAggiungiDialog() {
    showDialog(context: context, builder: (BuildContext context) {
      return AddExerciseDialog(onAdd: aggiungiEsercizio);  
      });
  }

  void aggiungiEsercizio(String name, int reps, int sets, double weight) async {
    final Exercise ex = Exercise(name: name, reps: reps, sets: sets, weight: weight, exType: _selectedIndex + 1);
    await Provider.of<WorkoutProvider>(context, listen: false).aggiungiEsercizio(ex, wp.id!);
  }

  void modificaEsercizio(Exercise ex) async {
    await Provider.of<WorkoutProvider>(context, listen: false).modificaEsercizio(ex);
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
          children: [
            Expanded(
              child: FutureBuilder(future: Provider.of<WorkoutProvider>(context, listen: false).caricaEsercizi(wp.id!), builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
              
                return Consumer<WorkoutProvider>(builder: (context, provider, child) {
                  final workout = provider.workouts.firstWhere((workout) => workout.id == wp.id);
              
                  return ListView.builder(
                    itemCount: workout.exercises.where((exercise) => exercise.exType == _selectedIndex + 1).toList().length,
                    itemBuilder: (context, index) {
                      final exercise = workout.exercises.where((exercise) => exercise.exType == _selectedIndex + 1).toList()[index];
                      return ExerciseTile(onDelete: () async {
                        await provider.eliminaEsercizio(exercise.id!);
                      },
                      onEdit: (ex) {
                        modificaEsercizio(ex);
                      },
                      ex: exercise);
                    },
                  );
                }
                );
              }),
            ),
            Padding(
          padding: const EdgeInsets.all(20.0),
          child: ElevatedButton.icon(onPressed: () {
            mostraAggiungiDialog();
          }, label: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 10),
            child: Text("New Exercise", style: TextStyle(
              fontWeight: FontWeight.bold
            ),),
          ),
          icon: Icon(Icons.add),)
        )
          ],        
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage("assets/icons/chest.png"),
                  size: 40,
                  color: Colors.black,
                ),
                label: "Chest"),
             BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage("assets/icons/back.png"),
                  size: 40,
                  color: Colors.black,
                ),
                label: "Back"),
                BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage("assets/icons/leg.png"),
                  size: 40,
                  color: Colors.black,
                ),
                label: "Leg")
            ],
            currentIndex: _selectedIndex, 
            onTap: selectIndex, 
          ),
        ),
    );
  }
}