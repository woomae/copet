import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet/api/patchUserData.dart';
import 'package:pet/main/main_home.dart';
import 'package:pet/main/main_screen.dart';
import 'package:pet/providers/user_data_notifier_provider.dart';
import 'package:pet/providers/user_notifier_provider.dart';

import '../common/component/buttons/next_button.dart';
import '../style/colors.dart';

class loginend extends ConsumerWidget {
  const loginend({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.read(userDataProvider);

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                //const SizedBox(height: 100),
                ClipRRect(
                  child: Image.asset(
                    'asset/img/checkimg.png',
                  ),
                ),
                const SizedBox(height: 61),
                subtitle(),
              ],
            ),
            nextbutton_end()
          ],
        ),
      ),
    );
  }
}

class subtitle extends StatelessWidget {
  const subtitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      '회원가입 되었습니다.',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class nextbutton_end extends StatelessWidget {
  const nextbutton_end({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          foregroundColor: WHITE,
          backgroundColor: PRIMARY_COLOR,
          textStyle: TextStyle(color: WHITE),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          minimumSize: Size(100, 50),
        ),
        child: Text(
          '다음',
        ),
      ),
    );
  }
}