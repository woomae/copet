import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:pet/api/auth/authGoogle.dart';
import 'package:pet/api/auth/authKakao.dart';
import 'package:pet/common/layout/default_layout.dart';
import 'package:pet/login/login_type.dart';
import 'package:pet/main/main_home.dart';
import 'package:url_launcher/url_launcher.dart';

import '../common/component/main_tabbar.dart';
import '../utils/webview_login_widget.dart';

class mainlogin extends StatefulWidget {
  const mainlogin({super.key});

  @override
  State<mainlogin> createState() => _mainloginState();
}

class _mainloginState extends State<mainlogin>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _fadeAnimations;
  final String _title = 'COPET';
  double _titlePosition = -50; // 글자의 위치를 조절하는 변수
  bool _showButtons = false; // 버튼 표시 여부를 나타내는 변수

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3), // 전체 애니메이션 시간
      vsync: this,
    );


    // 각 글자의 fade 애니메이션을 만들기 위해 Staggered Animation을 구성
    _fadeAnimations = List.generate(_title.length, (index) {
      final start = index * (0.1 / _title.length); // 각 글자의 시작 시간
      final end = start + (3 / _title.length); // 각 글자의 끝나는 시간
      return Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(start, end, curve: Curves.easeInOut), // 자연스러운 curve 설정
        ),
      );
    });


    _animateText();
  }

  void _animateText() async {
    // 컨트롤러 실행 (애니메이션 시작)
    _controller.forward();

    // 글자가 다 나타나면 위치를 위로 이동
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _titlePosition = -200; // 글자를 위로 이동시킬 위치
    });

    // 애니메이션이 끝나면 버튼을 보여주기 위해 상태를 업데이트
    await Future.delayed(const Duration(seconds: 2)); // 글자 이동 후 잠시 대기
    setState(() {
      _showButtons = true; // 버튼을 보여줌
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: AnimatedContainer(
                duration: const Duration(seconds: 1), // 이동 애니메이션
                curve: Curves.easeInOut, // 애니메이션 곡선
                transform: Matrix4.translationValues(0, _titlePosition, 0), // 위치 이동
                child: Title(fadeAnimations: _fadeAnimations, title: _title),
              ),
            ),
            if (_showButtons)
              Align(
                alignment: Alignment(0.0, 0.6),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'asset/img/login/speechbubble.png', // PNG 아이콘 경로
                      width: 240,
                      height: 80,
                    ),
                    // _authgoogle(),
                    // const SizedBox(height: 10),
                    _authkakao(),
                    const SizedBox(height: 50), // 버튼과 화면 하단 간격 조정
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class Title extends StatelessWidget {
  final List<Animation<double>> fadeAnimations;
  final String title;


  const Title({super.key, required this.fadeAnimations, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(title.length, (index) {
        return FadeTransition(
          opacity: fadeAnimations[index], // 각 글자에 대해 fade 애니메이션 적용
          child: Text(
            title[index],
            style: TextStyle(
              fontFamily: 'Poetsen',
              color: Colors.black,
              fontSize: 80,
              letterSpacing: -5,
              shadows: [
                Shadow(
                  offset: Offset(0, 4), // y축으로 4의 offset
                  blurRadius: 4, // blur 정도
                  color: Colors.black.withOpacity(0.25), // 25% 투명도의 검정색
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

// class _authgoogle extends StatelessWidget {
//   const _authgoogle({super.key});
//
//   static const String _url = 'http://copet.life/auth/google';
//
//   Future<void> _launchURL(BuildContext context) async {
//     final response = await AuthGoogle.authGoogle();
//     final cookies = response.headers['set-cookie']?[0];
//     // 회원 가입 여부 확인
//     bool isRegistered = await checkRegistration(cookies);
//     print('___________________________________Received headers: $cookies');
//     if (isRegistered) {
//       // 회원 가입된 경우 페이지 이동
//       Navigator.push(
//           context, MaterialPageRoute(builder: (context) => mainhome()));
//     } else {
//       // 회원 가입되지 않은 경우 다른 페이지로 이동 또는 회원 가입 화면 표시
//       Navigator.push(
//           context, MaterialPageRoute(builder: (context) => logintype()));
//     }
//   }
//
//   Future<bool> checkRegistration(String? cookies) async {
//     // 쿠키를 서버로 전송하여 회원 가입 여부 확인
//     // 서버에서는 쿠키를 이용하여 회원 가입 여부를 확인하고 응답을 반환합니다.
//     // 이 예시에서는 간단히 회원 가입 여부를 확인하도록 구현합니다.
//     if (cookies != null && cookies.contains('userId')) {
//       return true; // 회원 가입된 경우
//     } else {
//       return false; // 회원 가입되지 않은 경우
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 300, // 너비 설정
//       height: 45, // 높이 설정
//       child: ElevatedButton(
//         onPressed: () async {
//           await _launchURL(context);
//         },
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Image.asset(
//               'asset/img/login/googleicon.png', // PNG 아이콘 경로
//               width: 25,
//               height: 25,
//             ),
//             Text(
//               '구글 로그인',
//               style: TextStyle(
//                 color: Colors.black,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(width: 25),
//           ],
//         ),
//         style: ElevatedButton.styleFrom(
//             backgroundColor: Color(0xFFF8F8F8),
//             minimumSize: Size(double.infinity, 45), // 버튼의 최소 크기 설정
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10),
//             )),
//       ),
//     );
//   }
// }

class _authkakao extends StatelessWidget {
  const _authkakao({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300, // 너비 설정
      height: 45, // 높이 설정
      child: ElevatedButton(
        onPressed: () async {
          final res = await AuthKakao.authKakao();
          final String url = res.realUri.toString();
          //api요청으로 카카오로그인하는 URL로 웹뷰 띄움.
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => WebviewLoginWidget(url: url)));
          //await _launchURL(context);
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 3, right: 3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                'asset/img/login/kakaoicon.png', // PNG 아이콘 경로
                width: 20,
                height: 20,
              ),
              Text(
                '카카오 로그인',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 20),
            ],
          ),
        ),
        style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFFFEEA1B),
            minimumSize: Size(double.infinity, 45), // 버튼의 최소 크기 설정
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            )),
      ),
    );
  }
}

// class SpeechBubblePainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.white
//       ..style = PaintingStyle.fill
//       ..strokeWidth = 2.0
//       ..maskFilter = MaskFilter.blur(BlurStyle.normal, 3); // 그림자 효과
//
//     final path = Path();
//
//     // 말풍선 외부 그리기
//     path.moveTo(0, 0);
//     path.lineTo(size.width + 10, 0);
//     // path.quadraticBezierTo(size.width + 10, 0, size.width + 10, 10);
//     path.lineTo(size.width + 10, size.height - 1);
//     //path.quadraticBezierTo(size.width, size.height - 10, size.width - 10, size.height - 10);
//     path.lineTo(20, size.height - 10);
//     //path.quadraticBezierTo(10, size.height - 10, 10, size.height - 20);
//     path.lineTo(10, 10);
//     //path.quadraticBezierTo(10, 0, 20, 0);
//
//     // 말풍선 꼬리 그리기
//     path.moveTo(size.width / 2 - 10, size.height - 10);
//     path.lineTo(size.width / 2, size.height);
//     path.lineTo(size.width / 2 + 10, size.height - 10);
//
//     canvas.drawShadow(path, Colors.black, 3, true); // 그림자
//     canvas.drawPath(path, paint);
//
//     // 외곽선 그리기
//     final borderPaint = Paint()
//       ..color = Colors.grey
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 2.0;
//     canvas.drawPath(path, borderPaint);
//   }
//
//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return false;
//   }
// }
