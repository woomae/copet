import 'package:flutter/material.dart';

class splashscreen extends StatelessWidget {
  const splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'COPET',
          style: TextStyle(
            fontSize: 80,
            fontFamily: 'Poetsen',
            color: Colors.black,
            letterSpacing: -5,
            shadows: [
              Shadow(
                color: Colors.black.withOpacity(0.3),
                offset: const Offset(3, 3),
                blurRadius: 15),
            ]
          ),
        ),
      ),

    );
  }
}
