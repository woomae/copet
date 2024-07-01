import 'package:flutter/material.dart';
import '../../../style/icons.dart';

PreferredSizeWidget PostAppBar(Function onClick){
  return AppBar(
    //titleSpacing: 0,
    backgroundColor: Colors.white,
    elevation: 0,
    leading : Back(),
    actions: [
      postButton(onClick: onClick)
    ],
    shape: const Border(
        bottom: BorderSide(color: Colors.grey ,width: 0.5)
    ),
    centerTitle: false,
  );
}

class postButton extends StatelessWidget {
  final Function onClick;
  postButton({
    required this.onClick,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 5),
      child: TextButton(
          onPressed: (){
            onClick();
          },
          child: Text('전송')
      ),
    );
  }
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
      child: Padding(
        padding: const EdgeInsets.only(left: 5),
        child: GO_BACK_ICON,
      ),
    );
  }
}
