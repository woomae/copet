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
          textformfield(onChanged: (e){
            ref.read(userDataProvider.notifier).updateUserData(pet_category:e);
            print(e);
          },),
          _Subtitle(),
          const SizedBox(height: 350.0),
          Row(
            children: [
              const SizedBox(width: 280.0),
              Nextbutton(onPressed: (){
                if(state.pet_category != null && state.pet_category != ''){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const loginname()),);
                  print(state.pet_category);
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
      '      반려동물 종',
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
      '         * 기입 시 아래 해시태그와 같이 저장됩니다.',
      style: TextStyle(
        color: Colors.grey,
      ),
    );
  }
}