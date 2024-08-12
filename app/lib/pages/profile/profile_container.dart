import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet/pages/profile/follow/follow.dart';
import 'package:pet/pages/profile/profile_modify.dart';
import 'package:pet/providers/user_notifier_provider.dart';
import '../../style/colors.dart';

class ProfileContainer extends ConsumerWidget {
  //나중엔 로그인 시 get요청 날려서 provider에 저장하고 가져와서 쓰는걸로

  const ProfileContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(UserProvider);
    return Column(
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Center(
                    child: Text(
                      state.nickname.isNotEmpty ? state.nickname : '닉네임',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'CherryBomb',
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Positioned(
                    right: MediaQuery.of(context).size.width / 2 -
                        76,
                    child: IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => const ProfileModify()));
                      },
                      icon: Image.asset(
                        'asset/img/profile/modify.png',
                        width: 15, // 이미지 너비 조절
                        height: 15, // 이미지 높이 조절
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                state.intro.isNotEmpty ? state.intro : '자기소개 한마디',
                style: TextStyle(
                  fontFamily: 'CherryBomb',
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                  color: Color(0xFF575757),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  splashFactory: NoSplash.splashFactory,
                  //foregroundColor: BLACK,
                ),
                onPressed: () {
                  //팔로워기능
                },
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '팔로워',
                        style: TextStyle(
                          fontFamily: 'Segoe',
                          color: Color(0xFF959595),
                        ),
                      ),
                      TextSpan(
                        text: ' 0', // 팔로워 수 추가
                        style: TextStyle(
                          fontFamily: 'Segoe',
                          color: Color(0xFF222222),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 30),
              TextButton(
                style: TextButton.styleFrom(
                  splashFactory: NoSplash.splashFactory,
                  //foregroundColor: Colors.red,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const followlist()));
                },
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '팔로잉',
                        style: TextStyle(
                          fontFamily: 'Segoe',
                          color: Color(0xFF959595),
                        ),
                      ),
                      TextSpan(
                        text: ' 0', // 팔로잉 수 추가
                        style: TextStyle(
                          fontFamily: 'Segoe',
                          color: Color(0xFF222222),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Container(
            width: 71,
            height: 30,
            decoration: BoxDecoration(
              color: Color(0xFFF7F7F7).withOpacity(0.9), // 배경색을 회색으로 설정
              borderRadius: BorderRadius.circular(5), // border radius 설정
            ),
            child: Center(
              child: Text(
                '#햄스터',
                style: TextStyle(
                  fontFamily: 'Segoe',
                  fontSize: 15,
                  color: Color(0xFF222222),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 71,
                height: 30,
                decoration: BoxDecoration(
                  color: Color(0xFFF7F7F7).withOpacity(0.9), // 배경색을 회색으로 설정
                  borderRadius: BorderRadius.circular(5), // border radius 설정
                ),
                child: Center(
                  child: Text(
                    '#활발함',
                    style: TextStyle(
                      fontFamily: 'Segoe',
                      fontSize: 15,
                      color: Color(0xFF222222),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                width: 71,
                height: 30,
                decoration: BoxDecoration(
                  color: Color(0xFFF7F7F7).withOpacity(0.9), // 배경색을 회색으로 설정
                  borderRadius: BorderRadius.circular(5), // border radius 설정
                ),
                child: Center(
                  child: Text(
                    '#활발함',
                    style: TextStyle(
                      fontFamily: 'Segoe',
                      fontSize: 15,
                      color: Color(0xFF222222),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}