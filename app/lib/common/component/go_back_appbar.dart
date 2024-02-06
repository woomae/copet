import 'package:flutter/material.dart';
import '../../style/icons.dart';

PreferredSizeWidget goBackAppBar(){
  return AppBar(
    //titleSpacing: 0,
    backgroundColor: Colors.white,
    elevation: 0,
    leading : IconButton( //onpressd가 null일때 자동으로 회색으로 변경됨
      color: Colors.black,
      icon: GO_BACK_ICON,
      iconSize: 20,
      onPressed: (){

      },
    ),
    shape: const Border(
        bottom: BorderSide(color: Colors.grey ,width: 0.5)
    ),
    centerTitle: false,
  );
}
