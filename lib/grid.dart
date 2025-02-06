import 'package:flutter/material.dart';
import 'package:sudoku_api/sudoku_api.dart';

class SudokuGrid extends StatefulWidget {
  final Puzzle puzzle;
  final Function(int, int) onCellSelected;
  final int? selectedRow;
  final int? selectedCol;

  const SudokuGrid({
    super.key,
    required this.puzzle,
    required this.onCellSelected,
    this.selectedRow,
    this.selectedCol,
  });
  @override
  _SudokuGridState createState() => _SudokuGridState();
}

class _SudokuGridState extends State<SudokuGrid> {
  @override
  Widget build(BuildContext context) {
    double gridSize = MediaQuery.of(context).size.width * 0.9;
    double cellSize = gridSize / 9;

    return SizedBox(
      width: gridSize,
      height: gridSize,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 9,
        ),
        itemCount: 81,
        itemBuilder: (context, index) {
          int row = index ~/ 9;
          int col = index % 9;
          int? value = widget.puzzle.board()?.matrix()?[row][col].getValue();
          bool isSelected = row == widget.selectedRow && col == widget.selectedCol;

          return InkWell(
            onTap: () => widget.onCellSelected(row, col),
            child: Container(
              width: cellSize,
              height: cellSize,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 0.3),
                color: isSelected
                    ? Colors.blueAccent.shade100.withAlpha(100)
                    : Colors.transparent,
              ),
              child: Center(
                child: Text(
                  value != null && value > 0 ? value.toString() : '',
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}