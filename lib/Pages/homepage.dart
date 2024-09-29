import 'package:flutter/material.dart';
import 'package:to_do_list/utils/todo_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();
  List toDoList = [
    ['Learn Flutter', false],
    ['Learn Dart', false],
    ['Learn Java', false],
  ];

  void checkBoxChanged(int index) {
    setState(() {
      toDoList[index][1] = !toDoList[index][1];
    });
  }

  void addTask() {
    setState(() {
      toDoList.add([_controller.text, false]);
      _controller.clear();
    });
  }

  void deleteTask(int index) {
    setState(() {
      toDoList.removeAt(index);
    });
  }

  void updateTask(int index) {
    _controller.text = toDoList[index][0];
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Update Task'),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(hintText: "Enter new task name"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  toDoList[index][0] = _controller.text;
                  _controller.clear();
                  Navigator.of(context).pop();
                });
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade200,
      appBar: AppBar(
        title: const Text('ToDo-List'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
          itemCount: toDoList.length,
          itemBuilder: (BuildContext context, index) {
            return TodoList(
              taskName: toDoList[index][0],
              taskDone: toDoList[index][1],
              onChanged: (value) => checkBoxChanged(index),
              deleteFunction: (context) => deleteTask(index),
              updateFunction: (context) => updateTask(index),
            );
          }),
      floatingActionButton: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: 'Add your notes',
                  filled: true,
                  fillColor: Colors.blue[50],
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ),
          ),
          FloatingActionButton(
            onPressed: addTask,
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
