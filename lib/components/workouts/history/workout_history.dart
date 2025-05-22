import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../models/workout_entry.dart';

class WorkoutHistory extends StatefulWidget {
  const WorkoutHistory({super.key});

  @override
  _WorkoutHistoryState createState() => _WorkoutHistoryState();
}

class _WorkoutHistoryState extends State<WorkoutHistory> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<WorkoutEntry>> workoutHistory={};

  Future<void> fetchWorkOutHistory()async{
    workoutHistory.clear();
    final box = await Hive.openBox('workout_history');
    if(box.isNotEmpty){
      final Map<DateTime, List<WorkoutEntry>> result = {};
      for (final key in box.keys) {
        final date = DateTime.parse(key);

        final rawList = box.get(key) as List<dynamic>;

        final List<WorkoutEntry> entries = rawList.map((item) {
          final map = Map<String, dynamic>.from(item);
          return WorkoutEntry(map['name'], map['details']);
        }).toList();

        result[date] = entries;
      }
      setState(() {
        workoutHistory=result;
      });
      print("workout-history: ${result}");
    }
  }

  List<WorkoutEntry> _getWorkoutsForDay(DateTime day) {
    return workoutHistory[DateTime.utc(day.year, day.month, day.day)] ?? [];
  }
@override
  void initState() {
    super.initState();
    fetchWorkOutHistory();
  }
  @override
  Widget build(BuildContext context) {
    print(workoutHistory);
    return Scaffold(
      appBar: AppBar(
        title: Text('Workout History'),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2025, 1, 1),
            lastDay: DateTime.utc(2026, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: CalendarFormat.week,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.blue.shade200,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              markerDecoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
            ),
            eventLoader: (day) => _getWorkoutsForDay(day),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _selectedDay == null || _getWorkoutsForDay(_selectedDay!).isEmpty
                  ? Center(child: Text('No workouts for selected day'))
                  : ListView.builder(
                itemCount: _getWorkoutsForDay(_selectedDay!).length,
                itemBuilder: (context, index) {
                  final entry = _getWorkoutsForDay(_selectedDay!)[index];
                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: Icon(Icons.fitness_center, color: Colors.blue),
                      title: Text(entry.name),
                      subtitle: Text("${entry.reps} reps"),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}


