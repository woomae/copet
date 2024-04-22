import 'package:flutter/material.dart';
import 'package:webview_cookie_manager/webview_cookie_manager.dart';

class logoutscreen extends StatelessWidget {
  const logoutscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Logout'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            // 쿠키 매니저 생성
            final cookieManager = WebviewCookieManager();

            // 에뮬레이터의 쿠키 삭제
            await cookieManager.clearCookies();

            // 쿠키 삭제 후, 로그아웃 화면으로 이동
            Navigator.pushReplacementNamed(context, '/login');
          },
          child: Text('Logout'),
        ),
      ),
    );
  }
}
