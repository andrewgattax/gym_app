import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gym_app/components/delete_exercise_dialog.dart';
import 'package:gym_app/models/Exercise.dart';

class ExerciseTile extends StatelessWidget {
  final Exercise ex;
  VoidCallback onDelete;
  ExerciseTile({required this.onDelete, required this.ex});


  Future<bool> mostraDeleteDialog(BuildContext context) async{
    return await showDialog(context: context, builder: (BuildContext context) {
      return DeleteExDialog();
    }) ?? false;
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
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255 ,241, 242, 246),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.fitness_center_outlined,
                  color: Colors.black,
                  size: 40,),
                ),
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
                      //Edita
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