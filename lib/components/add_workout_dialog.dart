import 'package:flutter/material.dart';

class AddWorkoutDialog extends StatelessWidget {
  AddWorkoutDialog({required this.onAdd});
  TextEditingController myController = TextEditingController();
  final Function(String) onAdd;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.all(40),
      title: Text("New Workout", style: TextStyle(
        fontWeight: FontWeight.bold
      ),),
      content: Container(
        width: 300,
        child: TextField(
          controller: myController,
          decoration: InputDecoration(hintText: "Workout name"),
          autofocus: true,
        ),
      ),
      actions: [
        ElevatedButton(onPressed: () {
          Navigator.of(context).pop();
        }, 
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white38,
          foregroundColor: Colors.black
        ),
        child: Text("Cancel")),
        ElevatedButton(onPressed: () {
          String workoutName = myController.text;
          if(workoutName.isNotEmpty) {
            onAdd(workoutName);
          }
          Navigator.of(context).pop();
        }, child: Text("Add Workout"))
      ],
    );
  }
}