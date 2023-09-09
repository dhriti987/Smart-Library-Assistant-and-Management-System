import 'package:flutter/material.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/video/library_bg_gif.gif'),
            fit: BoxFit.cover,
          ),
        ),
        child: Text('Welcome to Library page'),
      ),
    );
  }
}