import 'package:flutter/material.dart';
import 'package:pet/login/login_area.dart';
import 'package:pet/login/login_main.dart';
import 'package:pet/login/login_name.dart';
import 'package:pet/login/login_type.dart';
import 'package:auth_buttons/auth_buttons.dart';
import 'package:pet/login/login_end.dart';
import 'package:pet/common/component/appbar.dart';
import 'package:pet/pages/community/community_main.dart';
import 'package:pet/pages/community/posting.dart';
import 'package:pet/pages/profile/setting/setting_home.dart';

void main() {
  runApp(
      _App(),
  );
}

class _App extends StatelessWidget {

  const _App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: const TextTheme(
          bodySmall : TextStyle(fontSize: 12.0),
          bodyMedium : TextStyle(fontSize: 15.0),
          bodyLarge: TextStyle(fontSize: 20.0)
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.resolveWith((states) => Colors.transparent)
          )
        )
      ),
      home: Community(),
    );
  }
}

