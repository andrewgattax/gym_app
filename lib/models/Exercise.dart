class Exercise {
  final String name;
  final int repetitions;
  final int sets;

  Exercise({
    required this.name,
    required this.repetitions,
    required this.sets,
  });

  @override
  String toString() {
    return 'Exercise{name: $name, repetitions: $repetitions, sets: $sets}';
  }
}