import 'package:flutter/material.dart';

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

            // 쿠키 삭제 후, 로그아웃 화면으로 이동
            Navigator.pushReplacementNamed(context, '/login');
          },
          child: Text('Logout'),
        ),
      ),
    );
  }
}
