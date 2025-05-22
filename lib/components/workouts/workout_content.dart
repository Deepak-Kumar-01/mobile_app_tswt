import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app_tswt/components/workouts/workout_content_bloc.dart';
import 'package:mobile_app_tswt/models/exercise.dart';
import 'package:mobile_app_tswt/models/workout.dart';
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
  final PageController controller=PageController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(context)=>WorkoutBloc()..add(OnLoadWorkout()),
      child:BlocConsumer<WorkoutBloc,WorkoutState>(
        listener: (context,state){
          if(state is WorkoutSessionCompleted){
            Utils.showSuccessToast("Workout completed Successfully", context);
           Navigator.of(context).pushAndRemoveUntil( MaterialPageRoute(
             builder: (context) => const Home(),
           ),
                   (Route<dynamic> route) => false);
          }
        },
        builder: (context,state){
          _bloc = BlocProvider.of<WorkoutBloc>(context);
          if(state is ShowTimer){
            return const CountdownTimer();
          }
          if(state is WorkoutContentLoaded){
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(widget.workout.title),
                    ElevatedButton(onPressed: (){
                      _bloc.add(OnShowTimer(widget.workout.exercises));
                    }, child: Text("Start Workout"))
                  ],
                ),
              ),
            );
          }

          if(state is ShowExercises){
            int currentPage=state.current;
            int exerciseDuration=state.exerciseDuration;
            String exerciseGif=state.exercises[currentPage].gif;
            return Scaffold(
              body: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: controller,
                      itemCount: state.exercises.length,
                      physics: NeverScrollableScrollPhysics(), // disables horizontal scroll
                      itemBuilder: (context, index) {
                        Exercise exercise=state.exercises[currentPage];
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Text(
                                "${exerciseDuration}",
                                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Image.asset(exerciseGif),
                            Center(
                              child: Text(
                                exercise.name,
                                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
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
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Theme.of(context).brightness == Brightness.dark
                    ? const CircularProgressIndicator(
                  color: Colors.white,
                )
                    : CircularProgressIndicator(
                  color: Colors.blue[900],
                ),
              )
            ],
          ),
          );
        },
      )
    );
  }
}
