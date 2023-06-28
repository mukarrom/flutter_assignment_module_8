import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Task Manager',
      home: HomeScreen(),
    );
  }
}

/*
* Todo: Implement a main screen that displays a list of tasks.
* Todo:  Add a floating action button (FAB) that opens a dialog to add a new task.
* Todo: When the user clicks the FAB, display a dialog with text fields to input task details such as title, description, and deadline.
* Todo: Implement a "Save" button in the dialog to add the new task to the task list.
* Todo: Display the added tasks in the main screen's list.
* Todo: Implement a long press gesture on each task item in the list to open a bottom sheet.
* Todo: The bottom sheet should show the task details along with an option to  delete the task.
* Todo: The bottom sheet will always be closed when delete is pressed.
* Todo: Ensure that the parent screen updates automatically with the modified task details.
* */

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> tasks = [
    Task('Title', 'Description', '29 jun 2023'),
    Task('Title', 'Description', '29 jun 2023'),
    Task('Title', 'Description', '29 jun 2023'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: ListView.separated(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(tasks[index].title),
            subtitle:  Text(tasks[index].description),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            height: 0,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: (){},
      ),
    );
  }
}

/// tasks model
class Task {
  String title, description, deadline;
  Task(this.title, this.description, this.deadline);
}

