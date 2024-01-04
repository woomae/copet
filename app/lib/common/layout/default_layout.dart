import 'package:flutter/material.dart';

class DefaultLayout extends StatelessWidget {
  final Widget child;

  const DefaultLayout({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: child,
    );
  }
}

