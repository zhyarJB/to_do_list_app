import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoList extends StatelessWidget {
  const TodoList(
      {super.key,
      required this.taskName,
      required this.taskDone,
      required this.onChanged,
      this.deleteFunction,
      this.updateFunction});

  final String taskName;
  final bool taskDone;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? deleteFunction;
  final Function(BuildContext)? updateFunction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
            ),
            SlidableAction(
              onPressed: updateFunction,
              icon: Icons.edit,
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          color: Colors.lightBlue,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment
                .center, // Aligns both to the center vertically
            children: [
              Checkbox(
                value: taskDone,
                onChanged: onChanged,
                activeColor: Colors.white,
                checkColor: Colors.black,
              ),
              // Text widget wrapped in Expanded and softWrap enabled
              Expanded(
                child: Text(
                  taskName,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      decoration: taskDone
                          ? TextDecoration.lineThrough
                          : TextDecoration.none),
                  softWrap:
                      true, // Allow text to wrap to the next line if needed
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
