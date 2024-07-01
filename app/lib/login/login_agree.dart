import 'package:flutter/material.dart';
import 'package:pet/login/login_end.dart';
import 'package:pet/login/login_keyword.dart';

import '../style/colors.dart';

class loginagree extends StatefulWidget {
  const loginagree({super.key});

  @override
  State<loginagree> createState() => _loginagreeState();
}

class _loginagreeState extends State<loginagree> {
  bool allChecked = false;
  bool isChecked1 = false;
  bool isChecked2 = false;
  bool isChecked3 = false;
  bool isChecked4 = false;

  void toggleAllCheckboxes(bool? value) {
    setState(() {
      allChecked = value ?? false;
      isChecked1 = allChecked;
      isChecked2 = allChecked;
      isChecked3 = allChecked;
      isChecked4 = allChecked;
    });
  }

  void toggleCheckbox1(bool? value) {
    setState(() {
      isChecked1 = value ?? false;
      allChecked = isChecked1 && isChecked2 && isChecked3 && isChecked4;
    });
  }

  void toggleCheckbox2(bool? value) {
    setState(() {
      isChecked2 = value ?? false;
      allChecked = isChecked1 && isChecked2 && isChecked3 && isChecked4;
    });
  }

  void toggleCheckbox3(bool? value) {
    setState(() {
      isChecked3 = value ?? false;
      allChecked = isChecked1 && isChecked2 && isChecked3 && isChecked4;
    });
  }

  void toggleCheckbox4(bool? value) {
    setState(() {
      isChecked4 = value ?? false;
      allChecked = isChecked1 && isChecked2 && isChecked3 && isChecked4;
    });
  }

  bool areRequiredChecked() {
    return isChecked1 && isChecked2; // 예시로 isChecked2와 isChecked3가 필요한 체크박스라고 가정
  }

  @override
  Widget build(BuildContext context) {
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
          children: [
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 20),
              child: Row(
                children: [
                  agreetext(),
                  Spacer(),
                  Checkbox(
                    value: allChecked,
                    onChanged: toggleAllCheckboxes,
                    side: BorderSide(color: Color(0xFF6F6F6F), width: 1.0),
                    checkColor: Colors.white,
                    activeColor: PRIMARY_COLOR,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Divider(
                color: Color(0xFF6F6F6F),
                thickness: 1.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 20),
              child: Row(
                children: [
                  agreetextlist1(),
                  Spacer(),
                  Checkbox(
                    value: isChecked1,
                    onChanged: toggleCheckbox1,
                    side: BorderSide(color: Color(0xFF6F6F6F), width: 1.0),
                    checkColor: Colors.white,
                    activeColor: PRIMARY_COLOR,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 20),
              child: Row(
                children: [
                  agreetextlist2(),
                  Spacer(),
                  Checkbox(
                    value: isChecked2,
                    onChanged: toggleCheckbox2,
                    side: BorderSide(color: Color(0xFF6F6F6F), width: 1.0),
                    checkColor: Colors.white,
                    activeColor: PRIMARY_COLOR,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 20),
              child: Row(
                children: [
                  agreetextlist3(),
                  Spacer(),
                  Checkbox(
                    value: isChecked3,
                    onChanged: toggleCheckbox3,
                    side: BorderSide(color: Color(0xFF6F6F6F), width: 1.0),
                    checkColor: Colors.white,
                    activeColor: PRIMARY_COLOR,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 20, bottom: 100),
              child: Row(
                children: [
                  agreetextlist4(),
                  Spacer(),
                  Checkbox(
                    value: isChecked4,
                    onChanged: toggleCheckbox4,
                    side: BorderSide(color: Color(0xFF6F6F6F), width: 1.0),
                    checkColor: Colors.white,
                    activeColor: PRIMARY_COLOR,
                  ),
                ],
              ),
            ),
            nextbutton_agree(areRequiredChecked: areRequiredChecked()),
          ],
        ),
      ),
    );
  }
}

class agreetext extends StatelessWidget {
  const agreetext({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      '약관 전체 동의',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        fontFamily: 'Segoe',
      ),
    );
  }
}

class agreetextlist1 extends StatelessWidget {
  const agreetextlist1({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: '',
        style: DefaultTextStyle.of(context).style,
        children: <TextSpan>[
          TextSpan(
            text: '(필수) ',
            style: TextStyle(color: Colors.red, fontSize: 15),
          ),
          TextSpan(
            text: '개인정보 보호 동의 개인정보 보호 동의',
            style: TextStyle(color: Colors.black, fontSize: 15),
          ),
        ],
      ),
    );
  }
}

class agreetextlist2 extends StatelessWidget {
  const agreetextlist2({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: '',
        style: DefaultTextStyle.of(context).style,
        children: <TextSpan>[
          TextSpan(
            text: '(필수) ',
            style: TextStyle(color: Colors.red, fontSize: 15),
          ),
          TextSpan(
            text: '개인정보 보호 동의 개인정보 보호 동의',
            style: TextStyle(color: Colors.black, fontSize: 15),
          ),
        ],
      ),
    );
  }
}

class agreetextlist3 extends StatelessWidget {
  const agreetextlist3({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      '개인정보 보호 동의 개인정보 보호 동의',
      style: TextStyle(
        fontSize: 15,
      ),
    );
  }
}

class agreetextlist4 extends StatelessWidget {
  const agreetextlist4({super.key});

  @override
  Widget build(BuildContext context) {
    return Text('개인정보 보호 동의 개인정보 보호 동의',
      style: TextStyle(
        fontSize: 15,
      ),
    );
  }
}

class nextbutton_agree extends StatelessWidget {
  final bool areRequiredChecked;
  const nextbutton_agree({super.key, required this.areRequiredChecked});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ElevatedButton(
        onPressed: areRequiredChecked ? () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const loginkeyword()),
          );
        } : null,
        style: ElevatedButton.styleFrom(
          foregroundColor: WHITE,
          backgroundColor: areRequiredChecked ? PRIMARY_COLOR : Colors.grey,
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
