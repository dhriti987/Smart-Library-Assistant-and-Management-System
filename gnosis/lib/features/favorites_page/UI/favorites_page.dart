import 'package:flutter/material.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(width: double.maxFinite, height: double.maxFinite,decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 0, 40, 73),
            Color.fromARGB(255, 0, 20, 39),
          ],
        ),
      ),);
  }
}