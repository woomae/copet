import 'package:flutter/material.dart';

PreferredSizeWidget Appbar() {
  return AppBar(
    scrolledUnderElevation: 0,
    titleSpacing: 0,
    backgroundColor: Colors.white,
    elevation: 0,
    title: const Padding(
      padding: EdgeInsets.all(15.0),
      child: Text(
        'COPET',
        style: TextStyle(
          fontFamily: 'Poetsen',
          color: Colors.black,
          fontSize: 25,
        ),
      ),
    ),
    centerTitle: false,
  );
}
