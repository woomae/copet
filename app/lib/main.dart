import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:pet/api/getUser.dart';
import 'package:pet/common/component/widgets/spinner_widget.dart';
import 'package:pet/login/login_main.dart';
import 'package:pet/login/login_name.dart';
import 'package:pet/main/main_home.dart';
import 'package:pet/providers/user_notifier_provider.dart';
import 'package:pet/style/colors.dart';

import 'api/dioBaseOpstions.dart';
import 'const/models/token_user_model.dart';

void main() async{
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();

  final clientId = dotenv.env['CLIENT_ID'];
  await NaverMapSdk.instance.initialize(
      clientId: clientId,
      onAuthFailed: (error) {
        print('네이버 맵 인증오류 : $error');
      });

  runApp( //껐다 켜기만 해도 runApp 실행됨.
      ProviderScope(
          child: App()),
  );
}
class App extends ConsumerWidget {
  App({super.key});

  Future<bool> checkAccessToken(WidgetRef ref) async {
    final storage = FlutterSecureStorage();
    final accessToken = await storage.read(key: 'ACCESS_TOKEN');
    print("액세스 토큰 존재 : ${accessToken?.isNotEmpty}");
    //print('accessToken : $accessToken');
    if (accessToken != null) {
      final decodedUser = JwtDecoder.decode(accessToken);
      final TokenUserModel parsedUser = TokenUserModel.fromJson(token: decodedUser);
      dio.options.headers = {
        'Cookie' : 'user=$accessToken'
      };
      final res = await GetUser.getUser(parsedUser.userId.toString());
      ref.read(UserProvider.notifier).storeUserData(res);
      // 여기서 필요에 따라 사용자 등록 여부를 확인하고 true 또는 false 반환
      return true;
    }
    else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //토큰 소지 시 토큰 기반으로 userid 뽑아내서 유저 조회하고 바로 mainhome으로 보내는 로직 필요함.
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: const TextTheme(
          bodySmall : TextStyle(fontSize: 8.0, decorationThickness: 0),
          bodyMedium : TextStyle(fontSize: 12.0, decorationThickness: 0),
          bodyLarge: TextStyle(fontSize: 12.0, fontWeight:FontWeight.w500, decorationThickness: 0),
          titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,decorationThickness: 0),
          labelMedium: TextStyle(fontSize: 12.0, color: GREY3, decorationThickness: 0)

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


      home: Container(
        color: WHITE,
        child: FutureBuilder(
          future: checkAccessToken(ref),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot){
            if (snapshot.connectionState == ConnectionState.waiting) {
              return SpinnerWidget();
            }
            //비동기 작업 (회원가입 여부 판별) 완료 후
            else{
              if(snapshot.data == true){
                final userNickname = ref.watch(UserProvider).nickname;
                //sns 로그인을 통해 액세스 토큰은 존재하지만 자체 회원가입이 되어있지 않을 때.
                if(userNickname == '')
                  return loginname();
                else
                  return mainhome();
              }
              else
                return mainlogin();
            }
          },
        ),
      )
    );
  }
}

