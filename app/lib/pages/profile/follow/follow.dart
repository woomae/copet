import 'package:flutter/material.dart';
import 'package:pet/api/follow/getFollow.dart';
import 'package:pet/api/follow/post_follow.dart';
import 'package:pet/common/component/appbars/go_back_appbar.dart';
import 'package:pet/const/models/users_model.dart';
import 'package:pet/pages/profile/otherProfile/profile_other.dart';
import 'package:pet/style/colors.dart';

import '../../../api/follow/delete_follow.dart';
import '../../../common/component/widgets/spinner_widget.dart';
import '../../../const/models/friends_model.dart';

class followlist extends StatelessWidget {
  const followlist({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GoBackAppBar(),
      backgroundColor: WHITE,
      body: FutureBuilder(
        future: getFollow(),
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.waiting) 
            return SpinnerWidget();
          if (snapshot.hasError) {
            return Center(child: Text('error'));
          }
          if (snapshot.hasData) {
            return FriendsList(friends: snapshot.data!);
          }
          else
            return SizedBox();
        },
      ),
    );
  }
}

class FriendsList extends StatefulWidget {
  final Friends friends;
  const FriendsList({required this.friends});

  @override
  State<FriendsList> createState() => _FriendsListState();
}

class _FriendsListState extends State<FriendsList> {

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.friends.count, // 팔로워 수에 맞게 변경
      itemBuilder: (context, index) {
        final UsersModel user = widget.friends.users[index];
        if(widget.friends.count == 0)
          return Center(child: Text('팔로우 한 사람이 없습니다.'));
        else
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
                        backgroundImage:user.photo.isNotEmpty
                           ? NetworkImage(user.photo[0].imgPath) as ImageProvider
                            : AssetImage('asset/img/Yaoh.png') as ImageProvider
                      ),
                      SizedBox(width: 10),
                      Text(user.nickname,
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
                        offset: Offset(0,20),
                        icon: Icon(Icons.more_horiz),
                        onSelected: (value) {
                          if (value == '언팔로우') {
                            // 언팔로우 동작
                            try{
                             setState(() {
                               deleteFollow(user.id);
                             });
                            }catch(e){
                              print(e);
                            }
                          }
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: Colors.white.withOpacity(0.9),
                        itemBuilder: (BuildContext context) {
                          return [
                            PopupMenuItem<String>(
                              padding: EdgeInsets.all(0),
                              value: '언팔로우',
                              child: Center(
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 170, // 원하는 width 값 설정
                                  height: 46, // 원하는 height 값 설정
                                  child: Text(
                                    '언팔로우',
                                    style: TextStyle(color: Colors.red),
                                  ),
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