class Exercise {
   String name;
   int repetitions;
   int sets;
   int weight;

  Exercise({
    required this.name,
    required this.repetitions,
    required this.sets,
    required this.weight,
  });

  @override
  String toString() {
    return 'Exercise{name: $name, repetitions: $repetitions, sets: $sets}';
  }
}