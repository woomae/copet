import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet/api/follow/post_follow.dart';
import 'package:pet/common/component/buttons/common_button.dart';
import 'package:pet/const/models/users_model.dart';
import 'package:pet/providers/user_notifier_provider.dart';
import '../../style/colors.dart';

class ProfileContainer extends ConsumerWidget {

  //나중엔 로그인 시 get요청 날려서 provider에 저장하고 가져와서 쓰는걸로

  const ProfileContainer({
    super.key,
    this.otherState
  });
  final UsersModel? otherState;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final UsersModel state;
    if(otherState != null){
      state = otherState!;
    }else{
      state = ref.watch(UserProvider);
    }
    final myState = otherState != null ? ref.watch(UserProvider) : null;
    return Column(
      children: [
        Column(
          children: [
            SizedBox(height: 20,),
            Text(state.nickname, style: Theme.of(context).textTheme.bodyLarge,),
            Text(state.intro),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.location_on_outlined),
                Text(state.region),
              ],
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          //다른 사람 프로필페이지 일 때 팔로우 신청 버튼으로 변경
          child: otherState != null ? FollowButton(othersId: otherState!.id) : MyFollower()
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child:Column(
                  children: [
                    Text(state.petkeyword, style: Theme.of(context).textTheme.bodyLarge,)
                  ],)
        // 띄어쓰기 기준으로 슬라이싱해서 .toList() 하면 될듯?
        )]
    );
  }
}

class MyFollower extends StatelessWidget {
  const MyFollower ({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: TextButton(
        style: TextButton.styleFrom(
          splashFactory: NoSplash.splashFactory,
          foregroundColor: BLACK
        ),
        onPressed: (){
        },
        child: const Text('팔로워',
        style: TextStyle(decoration: TextDecoration.underline,color: BLACK)))
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15 ),
        child: TextButton(
        style: TextButton.styleFrom(
          splashFactory: NoSplash.splashFactory,
          foregroundColor: BLACK
        ),
        onPressed: () {
        },
        child: const Text('팔로잉',
        style: TextStyle(decoration: TextDecoration.underline, color: BLACK))),
        )
    ],);
  }
}

class FollowButton extends StatelessWidget {
  const FollowButton({
    super.key,
    required this. othersId
  });
  final int othersId;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CommonButton(onPressed: (){
          //PostFollow.postFollow(othersId);
        }, content: '팔로우'),
        CommonButton(onPressed: (){

        }, content: '메시지')
      ],);
  }
}

