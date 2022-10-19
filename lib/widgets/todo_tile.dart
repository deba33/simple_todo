import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTile extends StatelessWidget {
  final String taskName;
  final bool taskStatus;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? deleteTask;
  const TodoTile({
    super.key,
    required this.taskName,
    required this.taskStatus,
    required this.onChanged,
    required this.deleteTask,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
      ),
      child: Slidable(
          endActionPane: ActionPane(
            motion: const StretchMotion(),
            children: [
              SlidableAction(
                onPressed: deleteTask,
                icon: Icons.delete,
                backgroundColor: Theme.of(context).errorColor,
              ),
            ],
          ),
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: taskStatus
                    ? Colors.lightGreen.withAlpha(50)
                    : Theme.of(context).primaryColor.withAlpha(50),
              ),
              child: Row(
                children: [
                  Checkbox(
                    value: taskStatus,
                    onChanged: onChanged,
                    activeColor: Colors.black,
                    checkColor: Colors.green,
                  ),
                  Text(
                    taskName,
                    textScaleFactor: 1.2,
                    softWrap: true,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      decoration:
                          taskStatus ? TextDecoration.lineThrough : null,
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
