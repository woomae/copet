import 'package:flutter/material.dart';
import 'package:pet/common/component/appbars/go_back_appbar.dart';
import 'package:pet/pages/profile/otherProfile/profile_other.dart';

class followlist extends StatelessWidget {
  const followlist({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GoBackAppBar(),
      body: _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // 3개의 열로 구성된 그리드
          mainAxisSpacing: 40, // 주 축(수직 방향)의 간격
          crossAxisSpacing: 10, // 교차 축(수평 방향)의 간격
          childAspectRatio: 0.6, // 각 항목의 가로 세로 비율
        ),
        itemCount: 9, // 총 9개의 항목이라고 가정
        itemBuilder: (context, index) {
          return _FollowButton(
            nickname: '닉네임', // 예: 닉네임 1, 닉네임 2, ...
            imageAssetPath: 'asset/img/test/test${index % 4 + 1}.png',
            onTap: () {
              // 프로필 페이지로 이동하는 코드
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Profileother(), // ProfileOtherPage는 실제 프로필 페이지 클래스명
                ),
              );
            },// 예: avatar1.png, avatar2.png, ...
          );
        },
      ),
    );
  }
}

class _FollowButton extends StatelessWidget {
  final String nickname;
  final String imageAssetPath;
  final VoidCallback onTap;

  const _FollowButton({
    required this.nickname,
    required this.imageAssetPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // GestureDetector를 통해 탭 이벤트 처리
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage: AssetImage(imageAssetPath),
            backgroundColor: Colors.grey, // 이미지 로딩 전에 보일 색상
          ),
          SizedBox(height: 20),
          Text(
            nickname,
            style: TextStyle(
              fontFamily: 'CherryBomb',
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}