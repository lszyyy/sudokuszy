import 'package:flutter/material.dart';
import 'package:sudoku_starter/game.dart';
import 'package:sudoku_starter/grid.dart';

import 'SudokuApiHelper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SudokuScreen(),
    );
  }
}
