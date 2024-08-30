import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet/pages/profile/profile_container.dart';
import 'package:pet/pages/profile/profile_information_container.dart';
import 'package:pet/pages/profile/setting/setting_home.dart';
import 'package:pet/providers/user_notifier_provider.dart';
import 'package:pet/style/colors.dart';

class ProfileMain extends StatelessWidget {
  const ProfileMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    childWidget: ProfileContainer(),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 4,
            child: ProfileInformationContainer(),
          ),
        ],
      ),
    );
  }
}

class Profile extends ConsumerWidget {
  final Widget childWidget;
  const Profile({super.key, required this.childWidget});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userState = ref.watch(UserProvider);
    print(userState.photo.length);
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
              child:userState.photo.length != 0 ? Image.network(userState.photo[0]!) :
              Container(color: GREY2),
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
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: GREY2,
      padding: const EdgeInsets.only(right: 20),
      child: SafeArea(
        child: Align(
          alignment: Alignment.topRight,
          child: GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SettingHome()));
            },
            child: Image.asset(
              'asset/img/profile/settingicon.png',
              width: 31.09,
              height: 33.34,
            ),
          ),
        ),
      ),
    );
  }
}