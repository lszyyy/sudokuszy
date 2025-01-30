import 'package:flutter/material.dart';

import 'innerGrid.dart';

class GridScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Récupération de la hauteur et largeur de l'écran
    double height = MediaQuery
        .of(context)
        .size
        .height;
    double width = MediaQuery
        .of(context)
        .size
        .width;

    // Définition de la taille de la grille (moitié de l'écran)
    double boxSize = (width < height ? width : height) / 6;

    return Scaffold(
      body: Center(
        child: SizedBox(
          height: boxSize * 3,
          width: boxSize * 3,
          child: GridView.count(
            crossAxisCount: 3,
            children: List.generate(9, (index) {
              return Container(
                width: boxSize,
                height: boxSize,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent, width: 2),
                ),
                child: InnerGrid(boxSize: boxSize), // Ajout de la grille interne
              );
            }),
          ),
        ),
      ),
    );
  }
}