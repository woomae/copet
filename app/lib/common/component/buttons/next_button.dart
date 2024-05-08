import 'package:flutter/material.dart';

class Nextbutton extends StatelessWidget {

  final Function onPressed;
  const Nextbutton({
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
        primary: Colors.orange,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        minimumSize: Size(100, 50),
      ),
      child: Text(
        '다음',
      ),
    );
  }
}
