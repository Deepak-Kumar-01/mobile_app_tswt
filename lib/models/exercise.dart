class Exercise {
  final String name;
  final int durationSeconds;
  final int reps;
  final int sets;
  final String gif; // URL or local asset path to a GIF

  Exercise({
    required this.name,
    this.durationSeconds = 0,
    this.reps = 0,
    this.sets = 0,
    required this.gif,
  });
}