import 'package:hive_flutter/hive_flutter.dart';

class TodoDatabase {
  List todoList = [];
  final _myBox = Hive.box('simTodo');

  createInitialData() {
    todoList = [
      ['Do Exercise', false],
      ['Buy Sugar', false],
    ];
  }

  loadData() {
    todoList = _myBox.get('TODOLIST');
  }

  updateDatabase() {
    _myBox.put('TODOLIST', todoList);
  }
}
