import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../style/colors.dart';

class SpinnerWidget extends StatelessWidget {
  const SpinnerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 75,
        height: 75,
        child: CircularProgressIndicator(
          color: PRIMARY_COLOR,
          strokeWidth: 3,
        ),
      ),
    );
  }
}
