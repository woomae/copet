import 'package:flutter/material.dart';
import 'package:pet/login/login_name.dart';
import 'package:pet/login/login_type.dart';
import 'package:pet/login/login_end.dart';

const List<String> list1 = <String>['지역선택', 'Twwwwo', 'Three', 'Four'];
const List<String> list2 = <String>['지역선택', '1', '2', '3'];
const List<String> list3 = <String>['지역선택', '4', '5', '6'];

class loginarea extends StatelessWidget {
  const loginarea({super.key});

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
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Title(),
              const SizedBox(height: 10.0),
              Center(
                child: Container(
                  height: 45,
                  width: 380,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30), // 테두리 둥글게 만들기
                    border: Border.all(color: Colors.black, width: 1), // 테두리 스타일 설정
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: DropdownButtonExample1(),
                ),
              ),
              const SizedBox(height: 10.0),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      height: 45,
                      width: 185,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30), // 테두리 둥글게 만들기
                        border: Border.all(color: Colors.black, width: 1), // 테두리 스타일 설정
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 28),
                      child: DropdownButtonExample2(),
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Center(
                    child: Container(
                      height: 45,
                      width: 185,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30), // 테두리 둥글게 만들기
                        border: Border.all(color: Colors.black, width: 1), // 테두리 스타일 설정
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 28),
                      child: DropdownButtonExample3(),
                    ),
                  ),
                ],
              ),

            ],
          ),
          Column(
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
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Prebutton(),
              const SizedBox(width: 20),
              Nextbutton(),
            ],
          )
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
      '      지역설정',
      style: TextStyle(
        fontSize: 18,
        color: Colors.black,
      ),
    );
  }
}

class DropdownButtonExample1 extends StatefulWidget {
  const DropdownButtonExample1({super.key});

  @override
  State<DropdownButtonExample1> createState() => _DropdownButtonExample1State();
}

class _DropdownButtonExample1State extends State<DropdownButtonExample1> {
  String dropdownValue = list1.first;

  //double menuWidth = 200.0; // 초기 값 설정, 원하는 값으로 조절


  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30), // 열릴 때의 모서리 둥글게 조절
      ),
      elevation: 0,
      onSelected: (String value) {
        setState(() {
          dropdownValue = value;
        });
      },


      itemBuilder: (BuildContext context) {
        return list1.map((String value) {
          // 각 항목의 너비를 측정
          //double itemWidth = getTextWidth(value, Theme.of(context).textTheme.bodyText2!);

          // 가장 긴 항목의 너비로 메뉴의 너비 설정
          //menuWidth = math.max(menuWidth, itemWidth);
          return PopupMenuItem<String>(
            value: value,
            child: Container(
              //width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30), // 각 아이템의 모서리 둥글게 조절
              ),
              child: Text(value),
            ),
          );
        }).toList();
      },
      child: Container(
        //width: menuWidth, // 버튼과 메뉴의 너비를 동일하게 설정
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // 아이콘을 오른쪽 끝으로 이동
          children: [
            Text(
              dropdownValue,
              style: const TextStyle(color: Colors.black),
            ),
            Icon(Icons.arrow_drop_down, size: 40, color: Colors.grey),
          ],
        ),
      ),
    );
  }

}

class DropdownButtonExample2 extends StatefulWidget {
  const DropdownButtonExample2({super.key});

  @override
  State<DropdownButtonExample2> createState() => _DropdownButtonExample2State();
}

class _DropdownButtonExample2State extends State<DropdownButtonExample2> {
  String dropdownValue = list2.first;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30), // 열릴 때의 모서리 둥글게 조절
      ),
      onSelected: (String value) {
        setState(() {
          dropdownValue = value;
        });
      },
      itemBuilder: (BuildContext context) {
        return list2.map((String value) {
          return PopupMenuItem<String>(
            value: value,
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30), // 각 아이템의 모서리 둥글게 조절
              ),
              child: Text(value),
            ),
          );
        }).toList();
      },
      child: Container(
        //padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                dropdownValue,
                style: const TextStyle(color: Colors.black),
              ),
            ),
            const Icon(Icons.arrow_drop_down, size: 40, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

class DropdownButtonExample3 extends StatefulWidget {
  const DropdownButtonExample3({super.key});

  @override
  State<DropdownButtonExample3> createState() => _DropdownButtonExample3State();
}

class _DropdownButtonExample3State extends State<DropdownButtonExample3> {
  String dropdownValue = list3.first;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30), // 열릴 때의 모서리 둥글게 조절
      ),
      onSelected: (String value) {
        setState(() {
          dropdownValue = value;
        });
      },
      itemBuilder: (BuildContext context) {
        return list3.map((String value) {
          return PopupMenuItem<String>(
            value: value,
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30), // 각 아이템의 모서리 둥글게 조절
              ),
              child: Text(value),
            ),
          );
        }).toList();
      },
      child: Container(
        //padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                dropdownValue,
                style: const TextStyle(color: Colors.black),
              ),
            ),
            const Icon(Icons.arrow_drop_down, size: 40, color: Colors.grey),
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
    return Text(
      '개인정보 보호동의 개인정보 보호동의'
    );
  }
}

class agreetextlist2 extends StatelessWidget {
  const agreetextlist2({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
        '개인정보 보호동의 개인정보 보호동의'
    );
  }
}

class agreetextlist3 extends StatelessWidget {
  const agreetextlist3({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
        '개인정보 보호동의 개인정보 보호동의'
    );
  }
}

class agreetextlist4 extends StatelessWidget {
  const agreetextlist4({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
        '개인정보 보호동의 개인정보 보호동의'
    );
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
        primary: Colors.orange,
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

class Nextbutton extends StatelessWidget {
  const Nextbutton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const loginend()),
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
          MaterialPageRoute(builder: (context) => const loginname()),
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