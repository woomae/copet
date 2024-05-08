import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet/main/main_screen.dart';
import 'package:pet/providers/user_data_notifier_provider.dart';

import '../common/component/buttons/next_button.dart';

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(width: 70),
                const SizedBox(width: 70),
                Nextbutton(onPressed: (){
                  //Navigator.pushAndRemoveUntil(
                    //  context, MaterialPageRoute(builder: (context) => mainscreen()), (route) => false);
                  print(state.pet_category);
                  print(state.nickname);
                  print(state.region_do);
                  print(state.petkeyword);
                  print(state.intro);

                },),
              ],
            )
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
