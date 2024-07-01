import 'package:flutter/material.dart';

import 'main_screen.dart';

const List<String> list1 = <String>['지역선택', 'Twwwwo', 'Three', 'Four'];
const List<String> list2 = <String>['지역선택', '1', '2', '3'];
const List<String> list3 = <String>['지역선택', '4', '5', '6'];

class mainplace extends StatelessWidget {
  const mainplace({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            //titleSpacing: 0,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            pinned: true,
            elevation: 0,
            title: Align(
              alignment: Alignment.centerRight,
              child: Text(
                'COPET',
                style: TextStyle(
                  fontFamily: 'Poetsen',
                  color: Colors.black,
                  fontSize: 25,
                ),
              ),
            ),
            leading: IconButton(
              icon: Icon(
                Icons.navigate_before,
                color: Colors.black,
              ),
              iconSize: 40,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const mainscreen()),
                );
              },
            ),
            centerTitle: false,
            shape: Border(
              bottom: BorderSide(
                color: Color(0xFFE6E6E6),
                width: 1,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child : Padding(
              padding: const EdgeInsets.only(top: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Title(),
                  const SizedBox(height: 10.0),
                  Center(
                    child: Container(
                      height: 45,
                      width: 380,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10), // 테두리 둥글게 만들기
                        border: Border.all(color: Color(0xFF6D6D6D), width: 1), // 테두리 스타일 설정
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 28),
                      child: DropdownButtonExample1(),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Container(
                          height: 45,
                          width: 185,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10), // 테두리 둥글게 만들기
                            border: Border.all(color: Color(0xFF6D6D6D), width: 1), // 테두리 스타일 설정
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
                            borderRadius: BorderRadius.circular(10), // 테두리 둥글게 만들기
                            border: Border.all(color: Color(0xFF6D6D6D), width: 1), // 테두리 스타일 설정
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 28),
                          child: DropdownButtonExample3(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),

                  SingleChildScrollView(
                    child: Container(
                      width: double.infinity,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Color(0xFFE7E7E7),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ],
              ),
            ),

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
      '      지역 설정',
      style: TextStyle(
        fontSize: 16,
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