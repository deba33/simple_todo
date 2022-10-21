import 'package:flutter/material.dart';
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

  // function for adding and saving new task
  _saveNewTask() {
    setState(() {
      if (_controller.text.trim().isEmpty) {
        return;
      } else {
        todoDB.todoList.add([_controller.text.trim(), false]);
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
