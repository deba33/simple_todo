import 'package:flutter/material.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../data/database.dart';
import '../widgets/todo_tile.dart';
import '../widgets/bottom_sheet.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // opening hive box
  final _myBox = Hive.box('mybox');
  // text controller
  final _controller = TextEditingController();
  // database class
  TodoDatabase todoDB = TodoDatabase();

  // function for checkbox clicking
  _checkBoxChanged(bool? value, int index) {
    setState(() {
      todoDB.todoList[index][1] = !todoDB.todoList[index][1];
    });
    todoDB.updateDatabase();
  }

  //function for adding alarm
  _addAlarm(String taskName, bool skipUI) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.dialOnly,
    );
    if (picked != null) {
      FlutterAlarmClock.createAlarm(
        picked.hour,
        picked.minute,
        title: taskName,
        skipUi: skipUI,
      );
    }
  }

  // function for adding and saving new task
  _saveNewTask() {
    setState(() {
      if (_controller.text.trim().isEmpty) {
        return;
      } else {
        _addAlarm(
          _controller.text.trim(),
          true,
        );
        todoDB.todoList.add([
          _controller.text.trim(),
          false,
        ]);
      }
      _controller.clear();
    });
    FocusScope.of(context).unfocus();
    todoDB.updateDatabase();
  }

  // function for deleting task
  _deleteTask(int index) {
    setState(() {
      todoDB.todoList.removeAt(index);
    });
    todoDB.updateDatabase();
  }

  @override
  void initState() {
    if (_myBox.get('TODOLIST') == null) {
      todoDB.createInitialData();
    } else {
      todoDB.loadData();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('TODO'),
        actions: [
          IconButton(
            onPressed: () {
              FlutterAlarmClock.showAlarms();
            },
            icon: const Icon(Icons.alarm),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          bottom: 90,
        ),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return TodoTile(
              taskName: todoDB.todoList[index][0],
              taskStatus: todoDB.todoList[index][1],
              onChanged: (value) => _checkBoxChanged(
                value,
                index,
              ),
              deleteTask: (context) {
                _deleteTask(index);
              },
              addAlarm: (context) {
                _addAlarm(
                  todoDB.todoList[index][0],
                  false,
                );
              },
            );
          },
          itemCount: todoDB.todoList.length,
        ),
      ),
      bottomSheet: TODOBottomSheet(
        controller: _controller,
        saveNewTask: _saveNewTask,
      ),
    );
  }
}
