import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../data/database.dart';
import '../widgets/todo_tile.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _myBox = Hive.box('mybox');
  final _controller = TextEditingController();

  TodoDatabase todoDB = TodoDatabase();

  checkBoxChanged(bool? value, int index) {
    setState(() {
      todoDB.todoList[index][1] = !todoDB.todoList[index][1];
    });
    todoDB.updateDatabase();
  }

  saveNewTask() {
    setState(() {
      if (_controller.text.trim().isEmpty) {
        return;
      }
      if (_controller.text.trim().length > 25) {
        todoDB.todoList.add([_controller.text.trim().substring(0, 25), false]);
      } else {
        todoDB.todoList.add([_controller.text.trim(), false]);
      }
      _controller.clear();
    });
    FocusScope.of(context).unfocus();
    todoDB.updateDatabase();
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
      body: Padding(
        padding: const EdgeInsets.only(
          bottom: 90,
        ),
        child: ListView.builder(
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
      ),
      bottomSheet: Container(
        height: 75,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 300,
              child: TextField(
                textInputAction: TextInputAction.done,
                onEditingComplete: saveNewTask,
                controller: _controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Add a new task',
                ),
              ),
            ),
            GestureDetector(
              onTap: saveNewTask,
              child: Container(
                width: 75,
                height: double.maxFinite,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Theme.of(context).primaryColor.withOpacity(0.4),
                ),
                child: const Icon(Icons.add),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
