// ignore_for_file: prefer_const_constructors

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gym_app/models/WorkoutPlan.dart';
import 'package:gym_app/pages/workout_detail.dart';

class WorkoutTile extends StatefulWidget {
  final WorkoutPlan wp;
  final VoidCallback onDelete;

  const WorkoutTile({required this.wp, required this.onDelete});

  @override
  State<WorkoutTile> createState() => _WorkoutTileState();
}

class _WorkoutTileState extends State<WorkoutTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
    child: InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => WorkoutDetail(wp: widget.wp)));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20)
          ),
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
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(widget.wp.name, style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                    ),),
                    Text(widget.wp.totalExercises.toString() + " exercises", style: TextStyle(
                      color: Colors.grey.shade600
                    ),)],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(onPressed: widget.onDelete, icon: Icon(Icons.delete_outline)),
              )
            ],
          ),
        ),
      ),
    ),);
  }
}