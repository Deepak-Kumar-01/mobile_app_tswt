class WorkoutEntry {
  final String name;
  final String reps;

  WorkoutEntry(this.name, this.reps);

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'details': reps,
    };
  }

  static WorkoutEntry fromMap(Map<String, dynamic> map) {
    return WorkoutEntry(
      map['name'] ?? '',
      map['reps'] ?? '',
    );
  }
}
