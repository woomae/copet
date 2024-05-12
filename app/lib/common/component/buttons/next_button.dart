import 'package:flutter/material.dart';

import '../../../style/colors.dart';

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
        foregroundColor: WHITE,
        backgroundColor: PRIMARY_COLOR,
        textStyle: TextStyle(color: WHITE),
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
