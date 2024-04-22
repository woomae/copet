import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet/api/getUser.dart';
import 'package:pet/login/login_main.dart';
import 'package:pet/main/main_home.dart';
import 'package:pet/providers/user_notifier_provider.dart';
import 'package:pet/style/colors.dart';

void main() async{
  await dotenv.load(fileName: ".env");
  
  runApp( //껐다 켜기만 해도 runApp 실행됨.
      const ProviderScope(
          child:
          _App()),
  );
}
class _App extends ConsumerWidget {
  const _App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    GetUser.getUser('1')
        .then((e) => ref.watch(UserProvider.notifier).storeUserData(e));

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
      home: mainlogin(),
    );
  }
}

