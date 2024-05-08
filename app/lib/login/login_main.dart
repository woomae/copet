
import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:pet/api/auth/authGoogle.dart';
import 'package:pet/api/auth/authKakao.dart';
import 'package:pet/common/layout/default_layout.dart';
import 'package:pet/login/login_type.dart';
import 'package:pet/main/main_home.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_cookie_manager/webview_cookie_manager.dart';

import '../common/component/main_tabbar.dart';
import '../common/component/utils/webview_login_widget.dart';

class mainlogin extends StatelessWidget {
  const mainlogin({super.key});


  @override
  Widget build(BuildContext context) {

    return DefaultLayout(
      child: SafeArea(
        top: true,
        bottom: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ClipRRect(
              child: Image.asset(
                'asset/img/copet_logo.png',
                width: 240,
                height: 150,
                //width: MediaQuery.of(context).size.width / 3 * 2,
              ),
              //borderRadius: BorderRadius.circular(30.0),
            ),
            Column(
              children: [
                _circleText(),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _authgoogle(),
//                _authapple(),
//                _authgithub(),
                    _authfacebook(),
                    _authkakao(),
                  ],
                ),
              ],
            ),
            //test(),
            //logoutscreen(),

          ],
        ),
      ),
    );
  }
}




class _circleText extends StatelessWidget {
  const _circleText({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        '3초만에 시작하기',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Colors.black,
          height: 2,
        ),
        textAlign: TextAlign.center,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(50.0)),
        boxShadow: const[
          BoxShadow(
              color: Colors.black54, // shadow color
              blurRadius: 4, // shadow radius
              offset: Offset(0, 4),
              spreadRadius:
              0.1,
              blurStyle: BlurStyle.normal // set blur style
          ),
        ]
      ),
      width: 241.0,
      height: 44.78,
    );
  }
}

//class _authgoogle extends StatelessWidget {
//  const _authgoogle({super.key});

//  @override
//  Widget build(BuildContext context) {
//    return GoogleAuthButton(
//      onPressed: () async {
//        _launchURL('http://copet.life/auth/kakao');
//      },
//      style: AuthButtonStyle(
//        buttonType: AuthButtonType.icon,
//      ),
//    );
//  }

//  static const String _url = 'http://copet.life/auth/kakao';

//  Future<void> _launchURL(String s) async {
//    if (!await launchUrl(Uri.parse(_url))) {

//      throw Exception('Could not launch $_url');
//    }
//  }
//}

class _authgoogle extends StatelessWidget {
  const _authgoogle({super.key});

  static const String _url = 'http://copet.life/auth/google';

  Future<void> _launchURL(BuildContext context) async {
    final response = await AuthGoogle.authGoogle();
    final cookies = response.headers['set-cookie']?[0];
    // 회원 가입 여부 확인
    bool isRegistered = await checkRegistration(cookies);
    print('___________________________________Received headers: $cookies');
    if (isRegistered) {
      // 회원 가입된 경우 페이지 이동
      Navigator.push(context, MaterialPageRoute(builder: (context) => mainhome()));
    } else {
      // 회원 가입되지 않은 경우 다른 페이지로 이동 또는 회원 가입 화면 표시
      Navigator.push(context, MaterialPageRoute(builder: (context) => logintype()));
    }
  }

  Future<bool> checkRegistration(String? cookies) async {
    // 쿠키를 서버로 전송하여 회원 가입 여부 확인
    // 서버에서는 쿠키를 이용하여 회원 가입 여부를 확인하고 응답을 반환합니다.
    // 이 예시에서는 간단히 회원 가입 여부를 확인하도록 구현합니다.
    if (cookies != null && cookies.contains('userId')) {
      return true; // 회원 가입된 경우
    } else {
      return false; // 회원 가입되지 않은 경우
    }




    if (!await launchUrl(Uri.parse(_url))) {

      throw Exception('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await _launchURL(context);
      },
      child: Text('googlelogin'),
    );
  }
}

// class _authapple extends StatelessWidget {
//   const _authapple({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return AppleAuthButton(
//       onPressed: () {},
//       style: AuthButtonStyle(
//         buttonType: AuthButtonType.icon,
//       ),
//     );
//   }
// }

// class _authgithub extends StatelessWidget {
//   const _authgithub({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return GithubAuthButton(
//       onPressed: () {},
//       style: AuthButtonStyle(
//         buttonType: AuthButtonType.icon,
//       ),
//     );
//   }
// }

class _authfacebook extends StatelessWidget {
  const _authfacebook({super.key});

  @override
  Widget build(BuildContext context) {
    return FacebookAuthButton(
      onPressed: () {},
      style: AuthButtonStyle(
        buttonType: AuthButtonType.icon,
      ),
    );
  }
}

class _authkakao extends StatelessWidget {
  const _authkakao({super.key});


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () async {
          final res = await AuthKakao.authKakao();
          final String url = res.realUri.toString();
          //api요청으로 카카오로그인하는 URL로 웹뷰 띄움.
          Navigator.push(context, MaterialPageRoute(builder: (context) => WebviewLoginWidget(url: url)));
          //await _launchURL(context);
        },
        child: Text('kakaologin'),
    );
  }
}

class test extends StatelessWidget {
  const test({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => maintabbar(),
        ));
      },
      child: Text(
        'test',
      ),
    );
  }
}

class logoutscreen extends StatelessWidget {
  const logoutscreen({super.key});


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(

          onPressed: () async {
            // 쿠키 매니저 생성
            final cookieManager = WebviewCookieManager();

            // 에뮬레이터의 쿠키 삭제
            await cookieManager.clearCookies();

            // 쿠키 삭제 후, 로그아웃 화면으로 이동
            Navigator.pushReplacementNamed(context, '/login_main');
          },
          child: Text('Logout'),
        );
  }
}









