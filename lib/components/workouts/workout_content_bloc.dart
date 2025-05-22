//Event

import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:mobile_app_tswt/models/exercise.dart';

abstract class WorkoutEvent {}

class OnLoadWorkout extends WorkoutEvent {}

class OnShowTimer extends WorkoutEvent {
  List<Exercise> exercises;
  OnShowTimer(this.exercises);
}

class AutoMoveToNextExercise extends WorkoutEvent {
  int exerciseNo;
  List<Exercise> exercises;
  AutoMoveToNextExercise(this.exerciseNo,this.exercises);
}
class OnWorkoutComplete extends WorkoutEvent{
  List<Exercise> exercises;
  OnWorkoutComplete({required this.exercises});
}

//State

abstract class WorkoutState {}

class WorkoutContentLoading extends WorkoutState {}

class WorkoutContentLoaded extends WorkoutState {}

class WorkoutSessionCompleted extends WorkoutState {}

class ShowTimer extends WorkoutState {}

// class ShowExercises extends WorkoutState {}

class ShowExercises extends WorkoutState {
  int current;
  int exerciseDuration;
  List<Exercise> exercises;
  ShowExercises({required this.current,required this.exerciseDuration,required this.exercises});
}

class WorkoutContentError extends WorkoutState {
  final String errorMsg;
  WorkoutContentError({required this.errorMsg});
}

//Bloc
class WorkoutBloc extends Bloc<WorkoutEvent, WorkoutState> {
  WorkoutBloc() : super(WorkoutContentLoading()) {
    on<OnLoadWorkout>((event, emit) async {
      emit(WorkoutContentLoaded());
    });
    on<OnShowTimer>((event, emit) async {
      emit(ShowTimer());
      await Future.delayed(Duration(seconds: 4));
      await _startExerciseTimer(
        emit: emit,
        duration: 3,
        currentIndex: 0,
        exercises: event.exercises,
      );
    });

    on<AutoMoveToNextExercise>((event, emit) async {
      emit(ShowTimer());
      await Future.delayed(Duration(seconds: 4));
      await _startExerciseTimer(
        emit: emit,
        duration: 3,
        currentIndex: event.exerciseNo,
        exercises: event.exercises,
      );
    });

    on<OnWorkoutComplete>((event, emit) async {
      print("Exercise ${event.exercises}");
      final today = DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day).toIso8601String();

      final box = await Hive.openBox('workout_history');
      List<Map<String, dynamic>> newEntries = event.exercises.map((exercise) {
        return {
          'name': exercise.name,
          'details': exercise.sets.toString(),
        };
      }).toList();

      final existingWorkout= (await box.get(today) as List<dynamic>?) ?? [];
      List<Map<String, dynamic>> updatedEntries = [];

      if (existingWorkout.isNotEmpty) {
        updatedEntries = existingWorkout.map((item) => Map<String, dynamic>.from(item)).toList();
        // Append today's new workouts
        updatedEntries.addAll(newEntries);
        print("updated records ${updatedEntries}");
        // Save using a string key
        await box.put(today, updatedEntries);
      }else{
        await box.put(today, newEntries);
      }

      // final Map<DateTime, List<WorkoutEntry>> result = {};
      //
      // for (final key in box.keys) {
      //   final date = DateTime.parse(key);
      //
      //   final rawList = box.get(key) as List<dynamic>;
      //
      //   final List<WorkoutEntry> entries = rawList.map((item) {
      //     final map = Map<String, dynamic>.from(item);
      //     return WorkoutEntry(map['name'], map['details']);
      //   }).toList();
      //
      //   result[date] = entries;
      // }
      // print("entries for ${result}");

      emit(WorkoutSessionCompleted());
    });

  }

  Future<void> _startExerciseTimer({
    required Emitter<WorkoutState> emit,
    required int duration,
    required int currentIndex,
    required List<Exercise> exercises,
  }) async {
    for (int i = duration; i >= 0; i--) {
      await Future.delayed(Duration(seconds: 1));
      if (i > 0) {
        emit(ShowExercises(
          current: currentIndex,
          exerciseDuration: i,
          exercises: exercises,
        ));
      } else {
        if (currentIndex < exercises.length - 1) {
          add(AutoMoveToNextExercise(currentIndex + 1, exercises));
        } else {
          add(OnWorkoutComplete(exercises: exercises));
        }
      }
    }
  }
}
