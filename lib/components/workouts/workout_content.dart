import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app_tswt/components/workouts/workout_content_bloc.dart';
import 'package:mobile_app_tswt/models/exercise.dart';
import 'package:mobile_app_tswt/models/workout.dart';
import 'package:mobile_app_tswt/utils/theme/custom_theme/text_theme.dart';
import 'package:mobile_app_tswt/utils/utils.dart';
import 'package:mobile_app_tswt/utils/widgets/countdown_timer_widget.dart';

import '../home/home.dart';

class WorkoutContent extends StatefulWidget {
  final Workout workout;
  const WorkoutContent({super.key, required this.workout});

  @override
  State<WorkoutContent> createState() => _WorkoutContentState();
}

class _WorkoutContentState extends State<WorkoutContent> {
  static late WorkoutBloc _bloc;
  final PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WorkoutBloc()..add(OnLoadWorkout()),
      child: BlocConsumer<WorkoutBloc, WorkoutState>(
        listener: (context, state) {
          if (state is WorkoutSessionCompleted) {
            Utils.showSuccessToast("Workout completed Successfully", context);
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const Home()),
              (Route<dynamic> route) => false,
            );
          }
        },
        builder: (context, state) {
          _bloc = BlocProvider.of<WorkoutBloc>(context);
          if (state is ShowTimer) {
            return CountdownTimer(pageColor: Colors.blue.shade900);
          }
          if (state is WorkoutContentLoaded) {
            return Scaffold(
              appBar: AppBar(),
              body: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.workout.title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      widget.workout.description,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  // Constrain the height of ListView
                  SizedBox(
                    height:
                        MediaQuery.of(context).size.height *
                        0.4,
                    child: ListView.builder(
                      itemCount: widget.workout.exercises.length,
                      itemBuilder: (context, index) {
                        Exercise exercise = widget.workout.exercises[index];
                        return ListTile(
                          title: Text(exercise.name),
                          leading: Image.asset(
                            widget.workout.exercises[index].gif,
                            width: 100,
                          ),
                          subtitle: Row(
                            children: [
                              Text(
                                "${widget.workout.exercises[index].reps} reps",
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      _bloc.add(OnShowTimer(widget.workout.exercises));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.blue[900],
                      minimumSize: const Size(64, 48),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child:  Text(
                      "Start Workout",
                      style: TextStyle(color:Theme.of(context).brightness==Brightness.dark?Colors.black: Colors.white),
                    ),
                  ),
                ],
              ),
            );
          }

          if (state is ShowExercises) {
            int currentPage = state.current;
            int exerciseDuration = state.exerciseDuration;
            String exerciseGif = state.exercises[currentPage].gif;
            return Scaffold(
              body: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: controller,
                      itemCount: state.exercises.length,
                      physics:
                          NeverScrollableScrollPhysics(), // disables horizontal scroll
                      itemBuilder: (context, index) {
                        Exercise exercise = state.exercises[currentPage];
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Text(
                                "${exerciseDuration}",
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Image.asset(exerciseGif),
                            Center(
                              child: Text(
                                exercise.name,
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
          return Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Authenticating, please wait"),
                const SizedBox(height: 20),
                Center(
                  child:
                      Theme.of(context).brightness == Brightness.dark
                          ? const CircularProgressIndicator(color: Colors.white)
                          : CircularProgressIndicator(color: Colors.blue[900]),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
