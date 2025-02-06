import 'package:flutter/material.dart';
import 'package:sudoku_api/sudoku_api.dart';

import 'innerGrid.dart';
class SudokuGrid extends StatelessWidget {
  final Puzzle puzzle;

  const SudokuGrid({super.key, required this.puzzle});

  @override
  Widget build(BuildContext context) {
    double gridSize = MediaQuery.of(context).size.width * 0.9;
    double cellSize = gridSize / 9;
    double boxSize = gridSize / 6;

    return SizedBox(
      width: gridSize,
      height: gridSize,
      child: GridView.builder(
        //  physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 9,
        ),
        itemCount: 81,
        itemBuilder: (context, index) {
          int row = index ~/ 9;
          int col = index % 9;
          int? value = puzzle.board()?.matrix()?[row][col].getValue();

          return Container(
            width: cellSize,
            height: cellSize,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 0.3),
            ),
            child: Center(
              child: Text(
                value != null && value > 0 ? value.toString() : '',
                style: const TextStyle(fontSize: 20),
              ),
            ),
          );
        },
      ),
    );
  }
}