import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet/style/colors.dart';


Future<bool> confirmDialog(BuildContext context) async {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),

        content: Text('삭제 하시겠습니까?', style: Theme.of(context).textTheme.bodyLarge),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false); // 취소(Cancel) 선택
            },
            child: Text('취소', style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: WARNING
            )),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true); // 수락(Confirm) 선택
            },
            child: Text('삭제', style: Theme.of(context).textTheme.bodyLarge),
          ),
        ],
      );
    },
  ).then((value) => value ?? false); // null 체크
}
