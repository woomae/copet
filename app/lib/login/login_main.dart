import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:pet/common/layout/default_layout.dart';

class mainlogin extends StatelessWidget {
  const mainlogin({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: SafeArea(
        top: true,
        bottom: false,
        child: Column(
          children: [
            const SizedBox(height: 70.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _Title(),
              ],
            ),
            const SizedBox(height: 30.0),
            Row(
              children: [
                SizedBox(width: 93.0),
                ClipRRect(
                  child: Image.asset(
                    'asset/img/copet_logo.png',
                    width: 240,
                    height: 150,
                    //width: MediaQuery.of(context).size.width / 3 * 2,
                  ),
                  //borderRadius: BorderRadius.circular(30.0),
                ),
              ],
            ),
            //const SizedBox(height: 10.0),
            _SubTitle1(),
            _SubTitle2(),
            const SizedBox(height: 70.0),
            _circleText(),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _authgoogle(),
                const SizedBox(width: 20.0),
                _authapple(),
                const SizedBox(width: 20.0),
                _authgithub(),
                const SizedBox(width: 20.0),
                _authfacebook(),
              ],
            ),

          ],
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'COPET',
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
    );
  }
}

class _SubTitle1 extends StatelessWidget {
  const _SubTitle1({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      '지금 코펫을\n이용해보세요!',
      style: TextStyle(
        fontSize: 30,
        color: Colors.black,
      ),
      textAlign: TextAlign.center,
    );
  }
}

class _SubTitle2 extends StatelessWidget {
  const _SubTitle2({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      '코펫과 함께 편리한 반려생활',
      style: TextStyle(
        fontSize: 16,
        color: Colors.grey,
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
          fontSize: 15,
          color: Colors.black,
          height: 1.7,
        ),
        textAlign: TextAlign.center,
      ),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      width: 150.0,
      height: 30.0,
    );
  }
}

class _authgoogle extends StatelessWidget {
  const _authgoogle({super.key});

  @override
  Widget build(BuildContext context) {
    return GoogleAuthButton(
      onPressed: () {},
      style: AuthButtonStyle(
        buttonType: AuthButtonType.icon,
      ),
    );
  }
}

class _authapple extends StatelessWidget {
  const _authapple({super.key});

  @override
  Widget build(BuildContext context) {
    return AppleAuthButton(
      onPressed: () {},
      style: AuthButtonStyle(
        buttonType: AuthButtonType.icon,
      ),
    );
  }
}

class _authgithub extends StatelessWidget {
  const _authgithub({super.key});

  @override
  Widget build(BuildContext context) {
    return GithubAuthButton(
      onPressed: () {},
      style: AuthButtonStyle(
        buttonType: AuthButtonType.icon,
      ),
    );
  }
}

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










