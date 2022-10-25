import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTile extends StatelessWidget {
  final String taskName;
  final bool taskStatus;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? deleteTask;
  final Function(BuildContext)? addAlarm;

  const TodoTile({
    super.key,
    required this.taskName,
    required this.taskStatus,
    required this.onChanged,
    required this.deleteTask,
    required this.addAlarm,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 15,
        right: 20,
        left: 20,
      ),
      child: Slidable(
        startActionPane: taskStatus
            ? null
            : ActionPane(
                motion: const StretchMotion(),
                extentRatio: 0.3,
                children: [
                  SlidableAction(
                    borderRadius: BorderRadius.circular(5),
                    onPressed: addAlarm,
                    icon: Icons.alarm_add,
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                ],
              ),
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          extentRatio: 0.3,
          children: [
            SlidableAction(
              borderRadius: BorderRadius.circular(5),
              onPressed: deleteTask,
              icon: Icons.delete,
              backgroundColor: Theme.of(context).errorColor,
            ),
          ],
        ),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: taskStatus
                  ? const Color(0xFFC8E6C9)
                  : const Color(0xFFFFECB3),
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
                    color: Colors.black,
                    decoration: taskStatus ? TextDecoration.lineThrough : null,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
