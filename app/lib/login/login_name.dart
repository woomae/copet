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
    bool isInputNotEmpty = state.nickname?.isNotEmpty ?? false;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        //titleSpacing: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          '회원가입',
          style: TextStyle(
            fontFamily: 'Poetsen',
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'COPET',
                style: TextStyle(
                  fontFamily: 'Poetsen',
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
        shape: Border(
          bottom: BorderSide(color: Color(0xFFDEDEDE), width: 1.0),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 90, bottom: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Title(),
            textformfield(
              text: state.nickname,
              hintText: 'ㆍ닉네임은 언제나 변경이 가능합니다.',
              onChanged: (e) {
                ref.read(userDataProvider.notifier).updateUserData(nickname: e);
                print(e);
              },
            ),
            Spacer(),
            Nextbutton(
              onPressed: () {
                if (state.nickname != null && state.nickname != '') {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => loginarea()));
                  print(state.nickname);
                }
              },
              enabled: isInputNotEmpty,
            ),
          ],
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30),
      child: Text(
        '닉네임',
        style: TextStyle(
          fontSize: 18,
          color: Colors.black,
        ),
      ),
    );
  }
}
