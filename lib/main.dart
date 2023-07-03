import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Task Management',
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
  ];
  final TextEditingController _titleTextEditingController =
      TextEditingController();
  final TextEditingController _descriptionTextEditingController =
      TextEditingController();
  final TextEditingController _deadlineTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Management'),
      ),
      body: ListView.separated(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return ListTile(
            onLongPress: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Task Details',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 28,
                                color: Colors.green),
                          ),
                          Text(
                            'Title: ${tasks[index].title}',
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            'Description: ${tasks[index].description}',
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            'Deadline: ${tasks[index].deadline}',
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                tasks.removeAt(index);
                                Navigator.pop(context);
                                if (mounted) {
                                  setState(() {});
                                }
                              },
                              child: const Text('Delete'))
                        ],
                      ),
                    );
                  });
            },
            title: Text(tasks[index].title),
            subtitle: Text(tasks[index].description),
          );
        },
        separatorBuilder: (context, index) {
          return const Divider(
            height: 0,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialogBox();
        },
      ),
    );
  }

  /// Dialog Box
  void showDialogBox() {
    showDialog(
        context: context,
        builder: (context) {
          return Expanded(
            child: AlertDialog(
              title: const Text('Add Tasks'),
              content: Column(
                children: [
                  TextField(
                    controller: _titleTextEditingController,
                    decoration: const InputDecoration(
                      hintText: 'Title',
                      border: OutlineInputBorder(),
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _descriptionTextEditingController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                        hintText: 'Description', border: OutlineInputBorder()),
                    maxLines: 5,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _deadlineTextEditingController,
                    decoration: const InputDecoration(
                      hintText: 'Deadline',
                      border: OutlineInputBorder(),
                    ),
                    textInputAction: TextInputAction.go,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: ElevatedButton(
                        onPressed: () {
                          if (_titleTextEditingController.text
                                  .trim()
                                  .isNotEmpty &&
                              _descriptionTextEditingController.text
                                  .trim()
                                  .isNotEmpty &&
                              _deadlineTextEditingController.text
                                  .trim()
                                  .isNotEmpty) {
                            tasks.add(Task(
                                _titleTextEditingController.text.trim(),
                                _descriptionTextEditingController.text.trim(),
                                _deadlineTextEditingController.text.trim()));
                            _titleTextEditingController.clear();
                            _descriptionTextEditingController.clear();
                            _deadlineTextEditingController.clear();
                            Navigator.pop(context);
                            if (mounted) {
                              setState(() {});
                            }
                          }
                        },
                        child: const Text('Add Task'),
                      )),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: ElevatedButton(
                        focusNode: FocusNode(),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      )),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}

/// tasks model
class Task {
  String title, description, deadline;
  Task(this.title, this.description, this.deadline);
}
