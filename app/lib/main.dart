import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet/api/getUser.dart';
import 'package:pet/login/login_main.dart';
import 'package:pet/login/login_type.dart';
import 'package:pet/main/main_home.dart';
import 'package:pet/providers/user_notifier_provider.dart';
import 'package:pet/style/colors.dart';

void main() async{
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();

  runApp( //껐다 켜기만 해도 runApp 실행됨.
      const ProviderScope(
          child: _App()),
  );
}
class _App extends ConsumerWidget {
  const _App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userRef = ref.watch(UserProvider);
    bool isRegistered = userRef.nickname != '' ? true : false;
    print(isRegistered);
    final userId = userRef.id;
    //쿠키를 가져온 이후
    if(userRef.id != 0){
      final res = GetUser.getUser(userRef.id.toString())
          .then((res) => ref.read(UserProvider.notifier).storeUserData(res))
          .onError((error, stackTrace){
            print(error);
            isRegistered = false;
          });
    }
    print('------------------------------------- userid : $userId');

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: const TextTheme(
          bodySmall : TextStyle(fontSize: 8.0, decorationThickness: 0),
          bodyMedium : TextStyle(fontSize: 12.0, decorationThickness: 0),
          bodyLarge: TextStyle(fontSize: 15.0, decorationThickness: 0),
          labelMedium: TextStyle(fontSize: 12.0, color: GREY1, decorationThickness: 0)

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
      home: mainhome()
      //userRef.id == 0 ? mainlogin() :
        //      isRegistered == false ? logintype() :
          //    mainhome()
    );
  }
}

