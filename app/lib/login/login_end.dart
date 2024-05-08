import 'package:flutter/material.dart';
import 'package:pet/login/login_type.dart';
import 'package:pet/main/main_home.dart';
import 'package:pet/main/main_screen.dart';

class loginend extends StatelessWidget {
  const loginend({super.key});

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
                Nextbutton(),
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

class Nextbutton extends StatelessWidget {
  const Nextbutton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const mainscreen()),
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