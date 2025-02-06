import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
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


  bool _isGameCompleted() {
    for (int row = 0; row < 9; row++) {
      for (int col = 0; col < 9; col++) {
        int? userValue = _puzzle!.board()?.matrix()?[row][col].getValue();
        int? expectedValue = _puzzle!.solvedBoard()?.matrix()?[row][col].getValue();
        if (userValue != expectedValue) {
          return false; // If any value is incorrect, the game is not finished
        }
      }
    }
    return true;
  }
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
      Position pos = Position(row: selectedRow!, column: selectedCol!);
      int? expectedValue = _puzzle!.solvedBoard()?.matrix()?[selectedRow!][selectedCol!].getValue();

      if (expectedValue == value) {
        // Correct value -> Update puzzle and UI
        setState(() {_puzzle!.board()!.cellAt(pos).setValue(value);});
        if (_isGameCompleted()) {
          Navigator.pushReplacementNamed(context, '/end'); // 🎉 Redirect to win screen
        }
      } else {
        // Incorrect value -> Show error message
        _showErrorSnackbar(value, expectedValue);
      }
    }

  }

  void _showErrorSnackbar(int enteredValue, int? correctValue) {
    final snackBar = SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: AwesomeSnackbarContent(
        title: 'Mauvaise valeur !',
        message: 'Le chiffre $enteredValue est incorrect.',
        contentType: ContentType.failure,
      ),
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
                onCellSelected: _selectCell,
                selectedRow: selectedRow,
                selectedCol: selectedCol,
              ),
            ),
          ),
          const SizedBox(height: 20),
          _buildNumberPad(),
          const SizedBox(height: 20),
          _buildTestEndButton(), // ✅ Added test button

        ],
      ),
    );
  }

  Widget _buildNumberPad() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) {
            return _buildNumberButton(index + 1);
          }),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(4, (index) {
            return _buildNumberButton(index + 6);
          }),
        ),
      ],
    );
  }
  Widget _buildTestEndButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, '/end'); // 🚀 Go to end screen for testing
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(16),
        backgroundColor: Colors.amber,
      ),
      child: const Text(
        'Aller à l\'écran de victoire',
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }
  Widget _buildNumberButton(int number) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: ElevatedButton(
        onPressed: () => _setCellValue(number),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(16),
          minimumSize: const Size(50, 50),
        ),
        child: Text(
          number.toString(),
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}