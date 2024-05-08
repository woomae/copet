import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet/providers/user_notifier_provider.dart';
import '../../style/colors.dart';

class ProfileContainer extends ConsumerWidget {

  //나중엔 로그인 시 get요청 날려서 provider에 저장하고 가져와서 쓰는걸로

  const ProfileContainer({
    super.key
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(UserProvider);
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          Column(
            children: [
              Text(state.nickname, style: Theme.of(context).textTheme.bodyLarge,),
              Text(state.intro),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.map),
                  Text(state.region),
                ],
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
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
                          //팔로워기능

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
                      onPressed: () {  },
                      child: const Text('팔로잉',
                          style: TextStyle(decoration: TextDecoration.underline, color: BLACK))),
                )
              ],),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:Column(
                    children: [
                      Text(state.petkeyword, style: Theme.of(context).textTheme.bodyLarge,)
                    ],)
          // 띄어쓰기 기준으로 슬라이싱해서 .toList() 하면 될듯?
          )]
      ),
    );
  }
}