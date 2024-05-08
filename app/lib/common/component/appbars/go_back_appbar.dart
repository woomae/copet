import 'package:flutter/material.dart';
import '../../../style/icons.dart';

PreferredSizeWidget GoBackAppBar(){
  return AppBar(
    //titleSpacing: 0,
    backgroundColor: Colors.white,
    elevation: 0,
    leading : Back(),
    shape: const Border(
        bottom: BorderSide(color: Colors.grey ,width: 0.5)
    ),
    centerTitle: false,
  );
}

class Back extends StatelessWidget {

  Back({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pop(context);
      },
      child: GO_BACK_ICON,
    );
  }
}
