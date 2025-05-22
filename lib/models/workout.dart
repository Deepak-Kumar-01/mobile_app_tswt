import 'exercise.dart';

class Workout {
  final String id;
  final String title;
  final String description;
  DateTime? completedAt;
  final List<Exercise> exercises;

  Workout({
    required this.id,
    required this.title,
    required this.description,
    this.completedAt,
    required this.exercises,
  });
}
