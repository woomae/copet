import 'package:flutter/material.dart';
import 'package:pet/login/login_keyword.dart';
import 'package:pet/pages/profile/profile_keyword.dart';
import '../../../style/icons.dart';

PreferredSizeWidget ModifyAppBar(BuildContext context){
  return AppBar(
    //titleSpacing: 0,
    backgroundColor: Colors.white,
    elevation: 0,
    leading : Back(),
    shape: const Border(
        bottom: BorderSide(color: Colors.grey ,width: 0.5)
    ),
    centerTitle: false,
    actions: [
      TextButton(
        onPressed: () {
          // Navigate to a new screen
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => profile_keyword()),
          );
        },
        child: Text(
          '다음',
          style: TextStyle(
            fontFamily: 'NotoSansKR',
            fontWeight: FontWeight.w400,
            color: Color(0xFF222222),
            fontSize: 20,
          ),
        ),
      ),
    ],
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
