import 'package:flutter/material.dart';
import 'package:pet/common/component/appbars/go_back_appbar.dart';
import 'package:pet/pages/profile/otherProfile/profile_other.dart';
import 'package:pet/style/colors.dart';

class followlist extends StatelessWidget {
  const followlist({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GoBackAppBar(),
      backgroundColor: WHITE,
      body: _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10, // 팔로워 수에 맞게 변경
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Profileother()), // ProfileOther 페이지로 이동
            );
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
            child: Container(
              child: Row(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage('asset/img/Yaoh.png'), // 프로필 이미지 경로 설정
                      ),
                      SizedBox(width: 10),
                      Text('닉네임',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'CherryBomb',
                          color: Color(0xFF222222),
                        ),), // 닉네임 설정
                    ],
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Container(
                        width: 65,
                        height: 35,
                        decoration: BoxDecoration(
                          color: Color(0xFFF0F0F0),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            '메시지',
                            style: TextStyle(
                              color: Color(0xFF222222),
                              fontFamily: 'NotoSansKR',
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      PopupMenuButton<String>(
                        icon: Icon(Icons.more_horiz),
                        onSelected: (value) {
                          // '차단하기' 및 '언팔로우' 동작 설정
                          if (value == '차단하기') {
                            // 차단하기 동작
                          } else if (value == '언팔로우') {
                            // 언팔로우 동작
                          }
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: Colors.white.withOpacity(0.9),
                        itemBuilder: (BuildContext context) {
                          return [
                            PopupMenuItem<String>(
                              value: '차단하기',
                              child: Container(
                                width: 170, // 원하는 width 값 설정
                                height: 46, // 원하는 height 값 설정
                                decoration: BoxDecoration(
                                  color: Colors.transparent,// 메뉴 항목의 배경색 설정
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      '차단하기',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    Spacer(),
                                    Image.asset(
                                      'asset/img/follow/trash.png', // 쓰레기통 아이콘 경로 설정
                                      width: 24,
                                      height: 24,
                                      color: Colors.red,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            PopupMenuItem<String>(
                              value: '언팔로우',
                              child: Container(
                                width: 170, // 원하는 width 값 설정
                                height: 46, // 원하는 height 값 설정
                                child: Text(
                                  '언팔로우',
                                ),
                              ),
                            ),
                          ];
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
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