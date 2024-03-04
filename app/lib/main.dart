import 'package:flutter/material.dart';
import 'package:pet/login/login_area.dart';
import 'package:pet/login/login_main.dart';
import 'package:pet/login/login_name.dart';
import 'package:pet/login/login_type.dart';
import 'package:auth_buttons/auth_buttons.dart';
import 'package:pet/login/login_end.dart';
import 'package:pet/common/component/appbar.dart';
import 'package:pet/const/taps.dart';
import 'package:pet/common/component/tapbar.dart';
import 'package:pet/main/logout.dart';
import 'package:pet/main/main_home.dart';
import 'package:pet/common/component/splashscreen.dart';

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
      home: mainlogin(),
    );
  }
}


