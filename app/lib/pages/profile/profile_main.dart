import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet/pages/profile/setting/setting_home.dart';
import 'package:pet/style/colors.dart';

class ProfileMain extends StatelessWidget {
  const ProfileMain({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: _Body(),
      ),
    );
  }
}
class _Body extends StatelessWidget {
  const _Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
            flex: 6,
            child: Stack(
              children: [
                BackgroundScreen(),
                Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: Profile(),
                ),
              ],
            ),
        ),
        Flexible(
            flex: 4,
            child: MyPost())
      ],
    );
  }
}

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: EdgeInsets.only(top: 50),
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 2,
                offset: Offset(0,-2)
              )
            ]
            ),
          child: ModifyContainer(),
        ),
        Positioned( //프로필 사진
            top: -50,
            child: Container(
              padding: EdgeInsets.all(5),
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 2,
                      offset: Offset(0,-2)
                    )
                  ],
                  borderRadius: BorderRadius.circular(150)
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                  child: Image.asset('asset/img/Yaoh.png')),
            )),
      ]
    );
  }
}
class ModifyContainer extends StatelessWidget {
  const ModifyContainer({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Text('닉네임', style: Theme.of(context).textTheme.bodyLarge,),
          Text('자기소개'),
          const Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('팔로워', style: TextStyle(decoration: TextDecoration.underline)),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('팔로잉', style: TextStyle(decoration: TextDecoration.underline)),
                )
              ],),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Row (
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('프로필 수정'),
                Text('프로필 수정'),
              ],),
          ),
          Text('해시태그 모음')
        ],
      ),
    );
  }
}

class MyPost extends StatelessWidget {
  const MyPost({
    super.key,});
  
Widget _smallCategory(String text){
  return Expanded(
    child: Container(
      padding: EdgeInsets.all(10),
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(width: 1, color: GREY_BORDER),)
      ),
        child: GestureDetector(
            onTap: (){

            },
            child: Text(text, style: TextStyle(color: GREY1),))
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              _smallCategory('산책'),
              _smallCategory('게시글'),
              _smallCategory('저장')
            ],),
          Column(
            children: [],)
        ],
      ),
    );
  }
}

class BackgroundScreen extends StatelessWidget {
  const BackgroundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: GREY2,
      padding: EdgeInsets.all(10),
      child: Align(
          alignment: Alignment.topRight,
          child: GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingHome()));
            },
              child: Icon(Icons.settings)))
    );
  }
}

