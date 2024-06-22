import 'package:flutter/material.dart';

import '../style/colors.dart';

class loginagree extends StatelessWidget {
  const loginagree({super.key});

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
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              agreetext(),
              const SizedBox(width: 70),
              const SizedBox(width: 70),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              agreetextlist1(),
              const SizedBox(width: 10),
              Checkbox1(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              agreetextlist2(),
              const SizedBox(width: 10),
              Checkbox2(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              agreetextlist3(),
              const SizedBox(width: 10),
              Checkbox3(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              agreetextlist4(),
              const SizedBox(width: 10),
              Checkbox4(),
            ],
          ),
          agreebutton(),
          nextbutton_agree(),
        ],
      ),
    );
  }
}


class agreetext extends StatelessWidget {
  const agreetext({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      '개인정보 보호동의',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class agreetextlist1 extends StatelessWidget {
  const agreetextlist1({super.key});

  @override
  Widget build(BuildContext context) {
    return Text('개인정보 보호동의 개인정보 보호동의');
  }
}

class agreetextlist2 extends StatelessWidget {
  const agreetextlist2({super.key});

  @override
  Widget build(BuildContext context) {
    return Text('개인정보 보호동의 개인정보 보호동의');
  }
}

class agreetextlist3 extends StatelessWidget {
  const agreetextlist3({super.key});

  @override
  Widget build(BuildContext context) {
    return Text('개인정보 보호동의 개인정보 보호동의');
  }
}

class agreetextlist4 extends StatelessWidget {
  const agreetextlist4({super.key});

  @override
  Widget build(BuildContext context) {
    return Text('개인정보 보호동의 개인정보 보호동의');
  }
}

class Checkbox1 extends StatefulWidget {
  const Checkbox1({super.key});

  @override
  State<Checkbox1> createState() => _Checkbox1State();
}

class _Checkbox1State extends State<Checkbox1> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.orange;
      }
      return Colors.white;
    }

    return Transform.scale(
      scale: 1,
      child: Checkbox(
        checkColor: Colors.black,
        fillColor: MaterialStateProperty.resolveWith(getColor),
        value: isChecked,
        onChanged: (bool? value) {
          setState(() {
            isChecked = value!;
          });
        },
      ),
    );
  }
}

class Checkbox2 extends StatefulWidget {
  const Checkbox2({super.key});

  @override
  State<Checkbox2> createState() => _Checkbox2State();
}

class _Checkbox2State extends State<Checkbox2> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.orange;
      }
      return Colors.white;
    }

    return Checkbox(
      checkColor: Colors.black,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
        });
      },
    );
  }
}

class Checkbox3 extends StatefulWidget {
  const Checkbox3({super.key});

  @override
  State<Checkbox3> createState() => _Checkbox3State();
}

class _Checkbox3State extends State<Checkbox3> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.orange;
      }
      return Colors.white;
    }

    return Checkbox(
      checkColor: Colors.black,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
        });
      },
    );
  }
}

class Checkbox4 extends StatefulWidget {
  const Checkbox4({super.key});

  @override
  State<Checkbox4> createState() => _Checkbox4State();
}

class _Checkbox4State extends State<Checkbox4> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.orange;
      }
      return Colors.white;
    }

    return Checkbox(
      checkColor: Colors.black,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;
        });
      },
    );
  }
}

class agreebutton extends StatelessWidget {
  const agreebutton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        foregroundColor: WHITE,
        backgroundColor: PRIMARY_COLOR,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        minimumSize: Size(120, 50),
      ),
      child: Text(
        '전체동의',
      ),
    );
  }
}

class nextbutton_agree extends StatelessWidget {
  const nextbutton_agree({super.key});

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