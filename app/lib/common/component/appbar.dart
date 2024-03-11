import 'package:flutter/material.dart';

class Appbar extends StatelessWidget {
  const Appbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        //titleSpacing: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'COPET',
          style: TextStyle(
            fontFamily: 'Poetsen',
            color: Colors.black,
            fontSize: 25,
          ),
        ),
        centerTitle: false,
      ),
    );
  }
}
