class Exercise {
  int? id;
   String name;
   int reps;
   int sets;
   int weight;
   int exType;

  Exercise({
    this.id,
    required this.name,
    required this.reps,
    required this.sets,
    required this.weight,
    required this.exType
  });

  @override
  String toString() {
    return 'Exercise{name: $name, repetitions: $reps, sets: $sets}';
  }

  Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'name': name,
      'reps': reps,
      'sets': sets,
      'weight': weight,
      'exType' : exType
    };
  }
}