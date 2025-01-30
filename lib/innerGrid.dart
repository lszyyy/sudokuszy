import 'package:flutter/material.dart';

class InnerGrid extends StatelessWidget {
  final double boxSize;

  const InnerGrid({super.key, required this.boxSize});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      physics: NeverScrollableScrollPhysics(), // Désactive le défilement
      children: List.generate(9, (index) {
        return Container(
          width: boxSize / 3,
          height: boxSize / 3,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 0.3),
          ),
        );
      }),
    );
  }
}