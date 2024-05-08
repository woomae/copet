import 'package:flutter/material.dart';
import 'package:pet/style/colors.dart';

class Prebutton extends StatelessWidget {
  final Function onPressed;
  const Prebutton({
    super.key,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed();
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: WHITE,
        backgroundColor: PRIMARY_COLOR,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        minimumSize: Size(100, 50),
      ),
      child: Text(
        '이전',
      ),
    );
  }
}