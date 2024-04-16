import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet/login/login_area.dart';
import 'package:pet/login/login_main.dart';
import 'package:pet/login/login_name.dart';
import 'package:pet/login/login_type.dart';
import 'package:auth_buttons/auth_buttons.dart';
import 'package:pet/login/login_end.dart';
import 'package:pet/common/component/appbars/appbar.dart';
import 'package:pet/main/main_home.dart';
import 'package:pet/pages/community/community_main.dart';
import 'package:pet/pages/profile/profile_main.dart';
import 'package:pet/pages/profile/setting/setting_home.dart';
import 'package:pet/style/colors.dart';

void main() async{
  await dotenv.load(fileName: ".env");
  runApp(
      ProviderScope(
          child:
          _App()),
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
          bodySmall : TextStyle(fontSize: 8.0),
          bodyMedium : TextStyle(fontSize: 12.0),
          bodyLarge: TextStyle(fontSize: 15.0),
          labelMedium: TextStyle(fontSize: 12.0, color: GREY1)

        ),
        iconButtonTheme: IconButtonThemeData(
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.resolveWith((states) => Colors.transparent)
          )
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            textStyle: MaterialStateProperty.resolveWith((states) => TextStyle(color: BLACK)),
            overlayColor: MaterialStateProperty.resolveWith((states) => Colors.transparent)
          )
        )
      ),
      home: mainhome(),
    );
  }
}

