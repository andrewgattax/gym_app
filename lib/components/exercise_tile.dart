import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gym_app/components/delete_exercise_dialog.dart';
import 'package:gym_app/components/edit_exercise_dialog.dart';
import 'package:gym_app/database/database_service.dart';
import 'package:gym_app/models/Exercise.dart';
import 'package:gym_app/providers/workout_provider.dart';
import 'package:provider/provider.dart';
import 'package:vibration/vibration.dart';

class ExerciseTile extends StatefulWidget {
  final Exercise ex;
  VoidCallback onDelete;
  Function(Exercise ex) onEdit;
  ExerciseTile({required this.onDelete, required this.ex, required this.onEdit});

  @override
  State<ExerciseTile> createState() => _ExerciseTileState();
}

class _ExerciseTileState extends State<ExerciseTile> {
  Future<bool> mostraDeleteDialog(BuildContext context) async{
    return await showDialog(context: context, builder: (BuildContext context) {
      return DeleteExDialog();
    }) ?? false;
  }

  mostraEditDialog(BuildContext context) async {
    if(await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(duration: 50, amplitude: 128);
    }
    showDialog(context: context, builder: (BuildContext context) {
      return EditExerciseDialog(onEdit: modificaEsercizio, exercise: widget.ex);  
      });
  }

  modificaEsercizio(String name, int reps, int sets, int weight) {
    widget.ex.name = name;
    widget.ex.reps = reps;
    widget.ex.sets = sets;
    widget.ex.weight = weight;
    widget.onEdit(widget.ex);
  }

  ImageIcon getIcon() {
    switch (widget.ex.exType) {
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

  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => mostraEditDialog(context),
      
      child: Listener(
        onPointerDown: (_) {
        setState(() {
          isHovering = true;
        });
      },
      onPointerCancel: (_) {
        setState(() {
          isHovering = false;
        });
      },
      onPointerUp: (_) {
        setState(() {
          isHovering = false;
        });
      },
        child: Padding(padding: EdgeInsets.symmetric(horizontal: 10),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            decoration: BoxDecoration(
              color: isHovering ? Colors.grey : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(20),
              /* boxShadow: isHovering
                    ? [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 20,
                          spreadRadius: .5,
                        )
                      ]
                    : [], */
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
                      children: [Text(widget.ex.name, style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold
                      ),),
                      Text(widget.ex.sets.toString() + " sets, " + widget.ex.reps.toString() + " reps", style: TextStyle(
                        color: Colors.grey.shade600
                      ),)],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    child: VerticalDivider(
                      width: 30,
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
                      Text(widget.ex.weight.toString() + "Kg", style: TextStyle(
                        color: Colors.grey.shade600
                      ),)],
                    ),
                  ),
                    ), 
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: IconButton(onPressed: () async {
                          bool confirm = await mostraDeleteDialog(context);
                          if(confirm) {
                            print("sesso");
                            widget.onDelete();
                          }
                        }, icon: Icon(Icons.delete_outline)),
                  )
                ],
              ),
            ),
          ),
        ),),
      ),
    );
  }
}