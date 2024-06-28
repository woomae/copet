import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet/common/component/text_form_field.dart';
import 'package:pet/login/login_name.dart';
import 'package:pet/providers/user_data_notifier_provider.dart';

import '../common/component/buttons/next_button.dart';

class logintype extends ConsumerWidget {
  const logintype({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(userDataProvider);
    bool isInputNotEmpty = state.pet_category?.isNotEmpty ?? false;

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
              text: state.pet_category,
              hintText: 'ㆍ기입 시 아래 해시태그와 같이 저장됩니다.',
              onChanged: (e) {
                ref
                    .read(userDataProvider.notifier)
                    .updateUserData(pet_category: e);
                print(e);
              },
            ),
            Spacer(),
            Nextbutton(
              onPressed: () {
                if (state.pet_category != null && state.pet_category != '') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const loginname()),
                  );
                  print(state.pet_category);
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
        '반려동물 종',
        style: TextStyle(
          fontSize: 18,
          color: Colors.black,
        ),
      ),
    );
  }
}
