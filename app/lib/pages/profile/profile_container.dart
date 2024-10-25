import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet/pages/profile/follow/follow.dart';
import 'package:pet/pages/profile/profile_modify.dart';
import 'package:pet/providers/user_data_notifier_provider.dart';
import 'package:pet/providers/user_notifier_provider.dart';
import '../../style/colors.dart';

class ProfileContainer extends ConsumerWidget {
  const ProfileContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(UserProvider);
    final userDataState = ref.watch(userDataProvider);

    // 선택된 pet 키워드들을 가져옵니다.
    final petKeywords = userDataState.petkeyword ?? [];

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
                      userDataState.nickname ?? '닉네임',
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'CherryBomb',
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Positioned(
                    right: MediaQuery.of(context).size.width / 2 - 76,
                    child: IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ProfileModify()),
                        );
                      },
                      icon: Image.asset(
                        'asset/img/profile/modify.png',
                        width: 15,
                        height: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                userDataState.intro ?? '자기소개 한마디',
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
                ),
                onPressed: () {
                  // 팔로워 기능
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
                        text: ' 0',
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
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const followlist()),
                  );
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
                        text: ' 0',
                        style: TextStyle(
                          fontFamily: 'Segoe',
                          color: Color(0xFF222222),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Container(
            width: 71,
            height: 30,
            decoration: BoxDecoration(
              color: Color(0xFFF7F7F7).withOpacity(0.9),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: Text(
                '#${userDataState.pet_category ?? '반려동물 종류'}',
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
            children: petKeywords.map((keyword) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: 30,
                  decoration: BoxDecoration(
                    color: Color(0xFFF7F7F7).withOpacity(0.9),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      '#$keyword',
                      style: TextStyle(
                        fontFamily: 'Segoe',
                        fontSize: 15,
                        color: Color(0xFF222222),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
