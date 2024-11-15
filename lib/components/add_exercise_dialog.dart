import 'package:flutter/material.dart';

class AddExerciseDialog extends StatelessWidget {
  AddExerciseDialog({required this.onAdd});
  TextEditingController nameController = TextEditingController();
  TextEditingController setsController = TextEditingController();
  TextEditingController repsController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  
  final Function(String, int, int, int) onAdd;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(20),
      title: Text("New Exercise", style: TextStyle(
        fontWeight: FontWeight.bold
      ),),
      content: Container(
        width: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(hintText: "Exercise name"),
              autofocus: true,
            ),
            Row(
              children: [Expanded(
                child: TextField(
                  controller: repsController,
                  decoration: InputDecoration(hintText: "Reps"),
                  keyboardType: TextInputType.number,),
              ),
                SizedBox(width: 10,),
                Expanded(
                  child: TextField(
                  controller: setsController,
                  decoration: InputDecoration(hintText: "Sets")),
                ),
                SizedBox(width: 10,),
                Expanded(
                  child: TextField(
                  controller: weightController,
                  decoration: InputDecoration(hintText: "Weight")),
                ),
                ],
            ),
            SizedBox(height: 10,)
          ],
        ),
      ),
      actions: [
        Row(
          children: [
            ElevatedButton(onPressed: () {
              Navigator.of(context).pop();
            }, 
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white38,
              foregroundColor: Colors.black
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text("Cancel"),
            )),
            SizedBox(width: 10,),
            Expanded(
              child: ElevatedButton(onPressed: () {
                        String workoutName = nameController.text;
                        int? reps = int.tryParse(repsController.text);
                        int? sets = int.tryParse(setsController.text);
                        int? weight = int.tryParse(weightController.text);
                        if(workoutName.isNotEmpty && reps != null && sets != null && weight != null) {
              onAdd(workoutName, reps, sets, weight);
                        }
                        Navigator.of(context).pop();
                      }, child: Text("Add")),
            )
          ],
        ),
        
      ],
    );
  }
}