import 'package:flutter/material.dart';
import 'package:pet/common/component/text_form_field.dart';
import 'package:pet/login/login_area.dart';
import 'package:pet/login/login_type.dart';

class loginname extends StatelessWidget {
  const loginname({super.key});

  @override
  Widget build(BuildContext context) {
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
          textformfield(),
          _Subtitle(),
          const SizedBox(height: 350.0),
          Row(
            children: [
              const SizedBox(width: 30.0),
              Prebutton(),
              const SizedBox(width: 160.0),
              Nextbutton(),
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

class Nextbutton extends StatelessWidget {
  const Nextbutton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const loginarea()),
        );
      },
      style: ElevatedButton.styleFrom(
        primary: Colors.orange,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        minimumSize: Size(100, 50),
      ),
      child: Text(
        '다음',
      ),
    );
  }
}

class Prebutton extends StatelessWidget {
  const Prebutton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const logintype()),
        );
      },
      style: ElevatedButton.styleFrom(
        primary: Colors.orange,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        minimumSize: Size(100, 50),
      ),
      child: Text(
        '이전',
      ),
    );
  }
}
