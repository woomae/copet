
import 'package:flutter/material.dart';
import 'package:pet/pages/profile/profile_container.dart';
import 'package:pet/pages/profile/profile_post_container.dart';
import 'package:pet/pages/profile/setting/setting_home.dart';
import 'package:pet/style/colors.dart';


class ProfileMain extends StatelessWidget {
  const ProfileMain({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
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
    return Container(
      color: WHITE,
      child: const Column(
        children: [
          Flexible(
              flex: 7,
              child: Stack(
                children: [
                  BackgroundScreen(),
                  Padding(
                    padding: EdgeInsets.only(top: 150),
                    child: Profile(childWidget: ProfileContainer()),
                  ),
                ],
              ),
          ),
          Flexible(
              flex: 4,
              child: MyPost())
        ],
      ),
    );
  }
}

class Profile extends StatelessWidget {
  final Widget childWidget;
  const Profile({
    super.key,
    required this.childWidget
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.only(top: 50),
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
          child: childWidget,
        ),
        Positioned( //프로필 사진
            top: -50,
            child: Container(
              padding: const EdgeInsets.all(5),
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
                borderRadius: const BorderRadius.all(Radius.circular(50)),
                  child: Image.asset('asset/img/Yaoh.png')),
            )),
      ]
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
      padding: const EdgeInsets.all(10),
      child: SafeArea(
        child: Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>const SettingHome()));
              },
                child: const Icon(Icons.settings))),
      )
    );
  }
}

