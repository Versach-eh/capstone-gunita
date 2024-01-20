// import 'package:flutter/material.dart';
// import 'package:table_calendar/table_calendar.dart';

// class Task {
//   String description;
//   DateTime dateTime;

//   Task({required this.description, required this.dateTime});
// }

// class ReminderScreen extends StatefulWidget {
//   const ReminderScreen({Key? key}) : super(key: key);

//   @override
//   _ReminderScreenState createState() => _ReminderScreenState();
// }

// class _ReminderScreenState extends State<ReminderScreen> {
//   int _currentIndex = 0; // Current index for bottom navigation

//   List<Task> tasks = [];
//   late CalendarController _calendarController; // Calendar controller
//   Map<DateTime, List<Task>> _events = {}; // Events mapped to dates

//   @override
//   void initState() {
//     super.initState();
//     _calendarController = CalendarController();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.blue[100],
//       appBar: AppBar(
//         title: Text('Task and Reminder'),
//         backgroundColor: Colors.blue[800],
//       ),
//       body: Column(
//         children: [
//           _buildCalendar(), // Calendar widget
//           Expanded(
//             child: ListView.builder(
//               itemCount: tasks.length,
//               itemBuilder: (context, index) {
//                 final task = tasks[index];
//                 return Card(
//                   elevation: 3,
//                   margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                   child: ListTile(
//                     title: Text(
//                       task.description,
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     subtitle: Text(
//                       'Due Date: ${task.dateTime.toString()}',
//                       style: TextStyle(fontStyle: FontStyle.italic),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           _showAddTaskDialog();
//         },
//         child: Icon(Icons.add),
//         backgroundColor: Colors.blue[800],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         items: [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.games),
//             label: 'Games',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.photo_album),
//             label: 'Album',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.settings),
//             label: 'Settings',
//           ),
//         ],
//         onTap: (index) {
//           setState(() {
//             _currentIndex = index;
//           });
//           // Implement navigation logic based on the index
//         },
//       ),
//     );
//   }

//   Widget _buildCalendar() {
//     return TableCalendar(
//       calendarController: _calendarController,
//       firstDay: DateTime(2000), // Provide your desired first day
//       lastDay: DateTime(2101), // Provide your desired last day
//       focusedDay: DateTime.now(), // Provide your desired focused day
//       onDaySelected: (date, events, holidays) {
//         // Handle day selection, e.g., display events for the selected date
//         setState(() {
//           // Update the tasks based on the selected date's events
//           tasks = events as List<Task>? ?? [];
//         });
//       },
//     );
//   }

//   void _showAddTaskDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Add Task'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Task Description'),
//                 onChanged: (value) {
//                   // You can handle the input here
//                 },
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   // Add the task to your tasks list or perform any desired action
//                   // For example, add a task with a description and the currently selected date.
//                   final selectedDate = _calendarController.selectedDay ?? DateTime.now();
//                   final newTask = Task(description: 'New Task', dateTime: selectedDate);
//                   setState(() {
//                     tasks.add(newTask);
//                   });
//                   Navigator.of(context).pop(); // Close the dialog
//                 },
//                 child: Text('Add'),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     home: ReminderScreen(),
//     debugShowCheckedModeBanner: false,
//   ));
// }
