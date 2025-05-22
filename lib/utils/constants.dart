import '../models/exercise.dart';
import '../models/workout.dart';

final workouts = <Workout>[
  Workout(
    id: 'w1',
    title: 'Full Body Burn',
    description: 'A mix of upper and lower body exercises to target the full body.',
    exercises: [
      Exercise(name: 'Jumping Jacks', reps: 2, gif: 'assets/workout_gifs/full_body_burn/jumping_jacks.gif'),
      Exercise(name: 'Push Ups', reps: 10, sets: 3, gif: 'assets/workout_gifs/full_body_burn/push_up.gif'),
      Exercise(name: 'Squats', reps: 15, sets: 3, gif: 'assets/workout_gifs/full_body_burn/squats.gif'),
    ],
  ),
  Workout(
    id: 'w2',
    title: 'Upper Body Pump',
    description: 'Focus on chest, shoulders, and arms.',
    exercises: [
      Exercise(name: 'Push Ups', reps: 12, sets: 3, gif: 'assets/workout_gifs/full_body_burn/push_up.gif'),
      Exercise(name: 'Shoulder Taps', reps: 10, sets: 3, gif: 'assets/workout_gifs/upper_body_pump/shoulder_tap_pushup.gif'),
      Exercise(name: 'Tricep Dips', reps: 15, sets: 3, gif: 'assets/workout_gifs/upper_body_pump/triceps_dips.gif'),
    ],
  ),
  Workout(
    id: 'w3',
    title: 'Leg Day Blast',
    description: 'Strengthen your legs with these focused exercises.',
    exercises: [
      Exercise(name: 'Lunges', reps: 12, sets: 3, gif: 'assets/workout_gifs/leg_day/lunges.gif'),
      Exercise(name: 'Horizontal Leg Push', durationSeconds: 45, gif: 'assets/workout_gifs/leg_day/sled_horizontal_leg_press.gif'),
      Exercise(name: 'Leg Press', reps: 20, sets: 3, gif: 'assets/workout_gifs/leg_day/sled_leg_press.gif'),
    ],
  ),
];