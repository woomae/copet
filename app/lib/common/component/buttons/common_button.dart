import 'package:flutter/material.dart';

import '../../../style/colors.dart';

class CommonButton extends StatelessWidget {
  final Function onPressed;
  final String content;
  const CommonButton({
    super.key,
    required this.onPressed,
    required this.content
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed();
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: WHITE,
        backgroundColor: GREY1,
        textStyle: TextStyle(color: BLACK),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        minimumSize: Size(100, 50),
      ),
      child: Text(
         content,
      ),
    );
  }
}
