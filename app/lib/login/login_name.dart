import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet/common/component/buttons/pre_button.dart';
import 'package:pet/common/component/text_form_field.dart';
import 'package:pet/login/login_area.dart';
import 'package:pet/login/login_type.dart';
import 'package:pet/providers/user_data_notifier_provider.dart';

import '../common/component/buttons/next_button.dart';

class loginname extends ConsumerWidget {
  const loginname({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(userDataProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        //titleSpacing: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'COPET',
          style: TextStyle(
            fontFamily: 'Poetsen',
            color: Colors.black,
            fontSize: 25,

          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Title(),
          textformfield(
            text: state.nickname,
            onChanged: (e){
            ref.read(userDataProvider.notifier).updateUserData(nickname: e);
            print(e);
          },),
          _Subtitle(),
          const SizedBox(height: 350.0),
          Row(
            children: [
              const SizedBox(width: 30.0),
              Prebutton(onPressed: (){
                Navigator.pop(context);
              },),
              const SizedBox(width: 160.0),
              Nextbutton(onPressed: (){
                if(state.nickname != null && state.nickname != ''){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => loginarea()));
                  print(state.nickname);
                }
                },),
            ],
          ),
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      '      닉네임',
      style: TextStyle(
        fontSize: 18,
        color: Colors.black,
      ),
    );
  }
}

class _Subtitle extends StatelessWidget {
  const _Subtitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      '         * 닉네임은 언제든 변경이 가능합니다.',
      style: TextStyle(
        color: Colors.grey,
      ),
    );
  }
}

