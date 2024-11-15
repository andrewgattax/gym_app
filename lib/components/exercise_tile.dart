import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gym_app/components/delete_exercise_dialog.dart';
import 'package:gym_app/components/edit_exercise_dialog.dart';
import 'package:gym_app/database/database_service.dart';
import 'package:gym_app/models/Exercise.dart';
import 'package:gym_app/providers/workout_provider.dart';
import 'package:provider/provider.dart';

class ExerciseTile extends StatelessWidget {
  final Exercise ex;
  VoidCallback onDelete;
  Function(Exercise ex) onEdit;
  ExerciseTile({required this.onDelete, required this.ex, required this.onEdit});


  Future<bool> mostraDeleteDialog(BuildContext context) async{
    return await showDialog(context: context, builder: (BuildContext context) {
      return DeleteExDialog();
    }) ?? false;
  }

  mostraEditDialog(BuildContext context) {
    showDialog(context: context, builder: (BuildContext context) {
      return EditExerciseDialog(onEdit: modificaEsercizio, exercise: ex);  
      });
  }

  modificaEsercizio(String name, int reps, int sets, int weight) {
    ex.name = name;
    ex.reps = reps;
    ex.sets = sets;
    ex.weight = weight;
    onEdit(ex);
  }

  ImageIcon getIcon() {
    switch (ex.exType) {
      case 1:
        return ImageIcon(
          AssetImage("assets/icons/chest.png"),
          size: 40,
          color: Colors.black);
      case 2:
        return ImageIcon(
          AssetImage("assets/icons/back.png"),
          size: 40,
          color: Colors.black);
      case 3:
        return ImageIcon(
          AssetImage("assets/icons/leg.png"),
          size: 40,
          color: Colors.black);
      default:
        return ImageIcon(
          AssetImage("assets/icons/chest.png"),
          size: 40,
          color: Colors.black);       
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.symmetric(horizontal: 20),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(20)
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset("assets/icons/exercise.svg",
                  width: 40,
                  height: 40,
                  colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),))
                ),
              SizedBox(width: 15),
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text(ex.name, style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                  ),),
                  Text(ex.sets.toString() + " sets, " + ex.reps.toString() + " reps", style: TextStyle(
                    color: Colors.grey.shade600
                  ),)],
                ),
              ),
              SizedBox(
                height: 40,
                child: VerticalDivider(
                  width: 50,
                  thickness: 2,
                  color: Colors.grey,
                ),
              ),
              Expanded(
                child: Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text("Weight", style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                  ),),
                  Text(ex.weight.toString() + "Kg", style: TextStyle(
                    color: Colors.grey.shade600
                  ),)],
                ),
              ),
                ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    IconButton(onPressed: () {
                      mostraEditDialog(context);
                    }, icon: Icon(Icons.edit)),
                    SizedBox(width: 10,),
                    IconButton(onPressed: () async {
                      bool confirm = await mostraDeleteDialog(context);
                      if(confirm) {
                        print("sesso");
                        onDelete();
                      }
                    }, icon: Icon(Icons.delete_outline)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ),);
  }
}