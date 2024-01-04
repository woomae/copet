import 'package:flutter/material.dart';
import 'package:pet/login/login_main.dart';
import 'package:auth_buttons/auth_buttons.dart';

void main() {
  runApp(
      _App(),
  );
}

class _App extends StatelessWidget {

  const _App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: mainlogin(),
    );
  }
}

