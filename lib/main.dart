import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import './screens/home.dart';

void main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox('simTodo');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: const Home(),
    );
  }
}
