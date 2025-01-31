import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_workout/models/Exercise.dart';
import 'package:my_workout/models/WorkoutPlan.dart';

class DeleteWpDialog extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Delete workout?", style: TextStyle(
        color: Colors.grey.shade600
      ),),
      actions: 
      [
        Row(
        children: [ElevatedButton.icon(onPressed: () {
        Navigator.of(context).pop(false);
      },
      label: Text("Cancel"),
      icon: Icon(Icons.cancel),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey,
        iconColor: Colors.white
      )),
      SizedBox(width: 10,),
        ElevatedButton.icon(onPressed: () {
        Navigator.of(context).pop(true);
      }, label: Text("Confirm"),
       icon: Icon(Icons.delete),
       style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        iconColor: Colors.white
      ),), ],
      )
      ],
    );
  }
}