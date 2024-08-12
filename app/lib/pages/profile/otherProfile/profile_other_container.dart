import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet/pages/profile/profile_modify.dart';
import 'package:pet/providers/user_notifier_provider.dart';
import '../../../style/colors.dart';

class ProfileotherContainer extends ConsumerWidget {
  //나중엔 로그인 시 get요청 날려서 provider에 저장하고 가져와서 쓰는걸로

  const ProfileotherContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final isFollowing = ref.watch(isFollowingProvider);
    final state = ref.watch(UserProvider);

    return Column(
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Center(
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
                onPressed: () {},
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
                onPressed: () {},
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
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 150,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Color(0xFFE6E6E6),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60),
                    ),
                    splashFactory: NoSplash.splashFactory,
                  ),
                  onPressed: () {
                    // 버튼 눌렀을 때 상태 업데이트
                    ref.read(isFollowingProvider.notifier).toggle(); // toggle 함수 호출
                  },
                  child: Text(
                    isFollowing ? '언팔로우' : '팔로우', // 상태에 따라 텍스트 변경
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Segoe',
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                width: 150,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Color(0xFFE6E6E6),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60),
                    ),
                    splashFactory: NoSplash.splashFactory,
                  ),
                  onPressed: () {
                    // 버튼 기능
                  },
                  child: Text(
                    '메세지',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Segoe',
                      fontSize: 15,
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

final isFollowingProvider = StateNotifierProvider<IsFollowingNotifier, bool>((ref) {
  return IsFollowingNotifier(); // IsFollowingNotifier 인스턴스 반환
});

// 상태를 변경할 StateNotifier 클래스 정의
class IsFollowingNotifier extends StateNotifier<bool> {
  IsFollowingNotifier() : super(false); // 초기 상태는 false로 설정

  void toggle() {
    state = !state; // 상태를 토글 (true -> false, false -> true)
  }
}