import 'package:flutter/material.dart';
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
  final _controller = TextEditingController();
  List todoList = [];

  checkBoxChanged(bool? value, int index) {
    setState(() {
      todoList[index][1] = !todoList[index][1];
    });
  }

  saveNewTask() {
    setState(() {
      if (_controller.text.length > 25) {
        todoList.add([_controller.text.substring(0, 25), false]);
      } else {
        todoList.add([_controller.text, false]);
      }
      _controller.clear();
    });
    Navigator.of(context).pop();
  }

  createNewTask() {
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
      todoList.removeAt(index);
    });
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
            taskName: todoList[index][0],
            taskStatus: todoList[index][1],
            onChanged: (value) => checkBoxChanged(
              value,
              index,
            ),
            deleteTask: (context) {
              deleteTask(index);
            },
          );
        },
        itemCount: todoList.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ),
    );
  }
}
