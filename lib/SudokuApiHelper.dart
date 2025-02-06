import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sudoku_api/sudoku_api.dart';

import 'grid.dart';

class SudokuScreen extends StatefulWidget {
  const SudokuScreen({super.key});

  @override
  _SudokuScreenState createState() => _SudokuScreenState();
}


class _SudokuScreenState extends State<SudokuScreen> {
  Puzzle? _puzzle;

  @override
  void initState() {
    super.initState();
    _generatePuzzle();
  }

  Future<void> _generatePuzzle() async {
    PuzzleOptions options = PuzzleOptions(patternName: "winter");
    Puzzle puzzle = Puzzle(options);
    await puzzle.generate();
    setState(() {
      _puzzle = puzzle;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sudoku')),
      body: Center(
        child: _puzzle == null
            ? const CircularProgressIndicator()
            : SudokuGrid(puzzle: _puzzle!),
      ),
    );
  }
}