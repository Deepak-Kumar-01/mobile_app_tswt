// print("Re-build");
// final PageController _controller=PageController();
// int _currentPage=0;
// List<Exercise> exercises=widget.workout.exercises;
// final isLastPage = _currentPage == exercises.length - 1;
// void _nextPage() {
// if (_currentPage < exercises.length - 1) {
// _controller.nextPage(
// duration: Duration(milliseconds: 300),
// curve: Curves.easeInOut,
// );
// }
// setState(() {
// _currentPage++;
// });
// }
// return Scaffold(
// appBar: AppBar(title: Text('Daily Workout')),
// body: Column(
// children: [
// Expanded(
// child: PageView.builder(
// controller: _controller,
// itemCount: exercises.length,
// physics: NeverScrollableScrollPhysics(), // disables horizontal scroll
// itemBuilder: (context, index) {
// Exercise exercise=exercises[index];
// return Center(
// child: Text(
// exercise.name,
// style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
// ),
// );
// },
// ),
// ),
// Padding(
// padding: const EdgeInsets.all(16.0),
// child: ElevatedButton(
// onPressed: isLastPage
// ? null // Optionally disable button when done
//     : _nextPage,
// child: Text(
// isLastPage ? 'Daily workout complete' : 'Next',
// ),
// style: ElevatedButton.styleFrom(
// minimumSize: Size(double.infinity, 50),
// ),
// ),
// )
// ],
// ),
// );