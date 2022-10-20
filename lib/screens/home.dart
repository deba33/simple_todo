import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:simple_todo/data/database.dart';
import '../widgets/todo_tile.dart';
import '../widgets/dialog_box.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _myBox = Hive.box('simTodo');

  TodoDatabase todoDB = TodoDatabase();

  final _controller = TextEditingController();

  checkBoxChanged(bool? value, int index) {
    setState(() {
      todoDB.todoList[index][1] = !todoDB.todoList[index][1];
    });
    todoDB.updateDatabase();
  }

  saveNewTask() {
    setState(() {
      if (_controller.text.length > 25) {
        todoDB.todoList.add([_controller.text.substring(0, 25), false]);
      } else {
        todoDB.todoList.add([_controller.text, false]);
      }
      _controller.clear();
    });
    todoDB.updateDatabase();
    Navigator.of(context).pop();
  }

  createNewTask() {
    setState(() {
      _controller.clear();
    });
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSaved: saveNewTask,
          onCancelled: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  deleteTask(int index) {
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
      body: ListView.builder(
        itemBuilder: (context, index) {
          return TodoTile(
            taskName: todoDB.todoList[index][0],
            taskStatus: todoDB.todoList[index][1],
            onChanged: (value) => checkBoxChanged(
              value,
              index,
            ),
            deleteTask: (context) {
              deleteTask(index);
            },
          );
        },
        itemCount: todoDB.todoList.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),
    );
  }
}
