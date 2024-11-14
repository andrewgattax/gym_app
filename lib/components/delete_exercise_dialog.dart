import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gym_app/models/Exercise.dart';
import 'package:gym_app/models/WorkoutPlan.dart';

class DeleteExDialog extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Delete exercise", style: TextStyle(
        color: Colors.grey.shade600
      ),),
      actions: [
        ElevatedButton.icon(onPressed: () {
        Navigator.of(context).pop(false);
      },
      label: Text("Cancel"),
      icon: Icon(Icons.cancel),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey,
        iconColor: Colors.white
      )),
        ElevatedButton.icon(onPressed: () {
        Navigator.of(context).pop(true);
      }, label: Text("Confirm"),
       icon: Icon(Icons.delete),
       style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        iconColor: Colors.white
      ),), 
      ],
    );
  }
}