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
  int? selectedRow;
  int? selectedCol;

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

  void _selectCell(int row, int col) {
    setState(() {
      selectedRow = row;
      selectedCol = col;
    });
  }

  void _setCellValue(int value) {
    if (_puzzle != null && selectedRow != null && selectedCol != null) {
      int pos = (selectedRow! * 9) + selectedCol!;
      _puzzle!.board()!.cellAt(pos as Position).setValue(value);
      setState(() {}); // Refresh UI after setting value
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sudoku')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: _puzzle == null
                  ? const CircularProgressIndicator()
                  : SudokuGrid(
                puzzle: _puzzle!,
                onCellSelected: _selectCell, // Pass selection callback
                selectedRow: selectedRow,
                selectedCol: selectedCol,
              ),
            ),
          ),
          const SizedBox(height: 20),
          _buildNumberPad(), // Add the number pad below the grid
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildNumberPad() {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 10,
      children: List.generate(9, (index) {
        int number = index + 1;
        return ElevatedButton(
          onPressed: () => _setCellValue(number),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(16),
            minimumSize: const Size(50, 50),
          ),
          child: Text(
            number.toString(),
            style: const TextStyle(fontSize: 24),
          ),
        );
      }),
    );
  }
}