import 'package:my_workout/models/Exercise.dart';

class ExType {
  int? id;
  String name;
  List<Exercise> exercises;

  ExType({this.id, required this.name, required this.exercises});

  aggiungiEsercizio(Exercise ex) {
    exercises.add(ex);
  }

  void rimuoviEsercizio(Exercise ex) {
    exercises.remove(ex);
  }

  @override
  String toString() {
    return 'ExType{id: $id, name: $name, exercises: $exercises}';
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name};
  }
}
