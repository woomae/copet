import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pet/pages/profile/profile_container.dart';
import 'package:pet/pages/profile/profile_information_container.dart';
import 'package:pet/pages/profile/otherProfile/profile_information_other.dart';
import 'package:pet/pages/profile/otherProfile/profile_other_container.dart';
import 'package:pet/pages/profile/setting/setting_home.dart';
import 'package:pet/style/colors.dart';

import '../../../style/icons.dart';

class Profileother extends StatelessWidget {
  const Profileother({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: _Body(),
    );

  }
}

class _Body extends StatelessWidget {
  const _Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: WHITE,
      child: Column(
        children: [
          Flexible(
            flex: 7,
            child: Stack(
              children: [
                BackgroundScreen(),
                Padding(
                  padding: EdgeInsets.only(top: 175),
                  child: Profile(
                    childWidget: ProfileotherContainer(),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 3,
            child: ProfileInformationother(),
          ),
        ],
      ),
    );
  }
}

class Profile extends StatelessWidget {
  final Widget childWidget;
  const Profile({super.key, required this.childWidget});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.only(top: 50),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(40),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.25),
                blurRadius: 2,
                offset: Offset(0, -4),
              )
            ],
          ),
          child: childWidget,
        ),
        Positioned(
          //프로필 사진
          top: -50,
          child: Container(
            padding: const EdgeInsets.all(5),
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.25),
                  blurRadius: 2,
                  spreadRadius: -1,
                  offset: Offset(0, -6),
                )
              ],
              borderRadius: BorderRadius.circular(150),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(50)),
              child: Image.asset('asset/img/Yaoh.png'),
            ),
          ),
        ),
      ],
    );
  }
}

class BackgroundScreen extends StatelessWidget {
  const BackgroundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 250,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFFFFFFF), // 완전 불투명한 흰색
                Color(0xFFFFEECC), // 연한 주황색
              ],
              stops: [0.0, 1.0], // 각 색상이 위치하는 비율
              begin: Alignment.topCenter, // 그라데이션 시작점 (왼쪽 위)
              end: Alignment.bottomCenter, // 그라데이션 끝점 (오른쪽 아래)
            ),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 17),
            child: Back(iconColor: Color(0xFFB0B0B0), width: 13.34, height: 22.63),
          ),
        ),
      ],
    );
  }
}

class Back extends StatelessWidget {
  final double width;
  final double height;
  final Color iconColor;

  const Back({
    super.key,
    this.width = 24.0,
    this.height = 24.0,
    this.iconColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        width: width,
        height: height,
        child: Icon(
          Icons.arrow_back_ios,
          color: iconColor,
        ),
      ),
    );
  }
}