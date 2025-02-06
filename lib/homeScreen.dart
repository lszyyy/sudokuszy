import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sudoku - Accueil')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/game'); // Navigate to game screen
          },
          child: const Text('Commencer une partie', style: TextStyle(fontSize: 20)),
        ),
      ),
    );
  }
}