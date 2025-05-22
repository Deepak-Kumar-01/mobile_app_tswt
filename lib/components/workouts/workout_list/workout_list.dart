import 'package:flutter/material.dart';

import '../../../models/workout.dart';
import '../../../utils/constants.dart';
import '../workout_content.dart';

class WorkoutList extends StatelessWidget {
  const WorkoutList({super.key});

  @override
  Widget build(BuildContext context) {
    List<Workout> workoutList=workouts;
    return Scaffold(
      appBar: AppBar(
        title: Text("Workouts"),
      ),
      body: ListView.builder(
          itemCount: workoutList.length,
          itemBuilder: (context,index){
            final workout= workoutList[index];
            return Card(
              margin: EdgeInsets.all(8),
              color: Colors.green,
              child: ListTile(
                title: Text(workout.title,style: Theme.of(context).textTheme.titleMedium),
                subtitle: Text(workout.description,style: TextStyle(color: Colors.white),),
                trailing: Icon(Icons.arrow_forward_ios,color: Colors.white,),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WorkoutContent(workout: workout),
                    ),
                  );
                },
              ),
            );
          }),
    );
  }
}
