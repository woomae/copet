import 'package:flutter/material.dart';

import 'main_place.dart';

class mainscreen extends StatelessWidget {
  const mainscreen({super.key});

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
            title: Text(
              'COPET',
              style: TextStyle(
                fontFamily: 'Poetsen',
                color: Colors.black,
                fontSize: 25,
              ),
            ),
            centerTitle: false,
            actions: [
              InkWell(
                onTap: () {},
                child: Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Image.asset(
                    'asset/img/alarm.png', // 원하는 이미지의 경로
                    width: 20.0, // 이미지의 너비
                    height: 21.54, // 이미지의 높이
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Image.asset(
                    'asset/img/mail.png', // 원하는 이미지의 경로
                    width: 25.0, // 이미지의 너비
                    height: 18.75, // 이미지의 높이
                  ),
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 32, left: 16, right: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          primary: Color(0xFFF2F2F2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          minimumSize: Size(186, 200),
                          elevation: 0,
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  '산책 가기',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 25,
                                    fontFamily: 'SnowCrap',
                                  ),
                                ),
                                const SizedBox(width: 30),
                              ],
                            ),
                            const SizedBox(height: 80),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const mainplace()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFFF2F2F2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              minimumSize: Size(196, 90),
                              elevation: 0,
                            ),
                            child: Align(
                              child: Row(
                                children: [
                                  Text(
                                    '펫플레이스',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 25,
                                      fontFamily: 'SnowCrap',
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  const SizedBox(width: 30),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFFF2F2F2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              minimumSize: Size(196, 90),
                              elevation: 0,
                            ),
                            child: Row(
                              children: [
                                Text(
                                  '커뮤니티',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 25,
                                    fontFamily: 'SnowCrap',
                                  ),
                                ),
                                const SizedBox(width: 55),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: Container(
                      width: 402,
                      height: 180,
                      decoration: BoxDecoration(
                        color: Color(0xFFF2F2F2),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      // 버튼이 클릭되었을 때 수행할 작업을 여기에 추가합니다.
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: CircleBorder(),
                                      minimumSize: Size(60, 60),
                                      elevation: 0,
                                      backgroundColor: Color(0xFFD9D9D9),
                                    ),
                                    child: Icon(
                                      Icons.circle,
                                      color: Color(0xFFD9D9D9D9),
                                      size: 24, // 아이콘의 크기 조절 가능
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    '일상',
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      // 버튼이 클릭되었을 때 수행할 작업을 여기에 추가합니다.
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: CircleBorder(),
                                      minimumSize: Size(60, 60),
                                      elevation: 0,
                                      backgroundColor: Color(0xFFD9D9D9),
                                    ),
                                    child: Icon(
                                      Icons.circle,
                                      color: Color(0xFFD9D9D9),
                                      size: 24, // 아이콘의 크기 조절 가능
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    '도움',
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      // 버튼이 클릭되었을 때 수행할 작업을 여기에 추가합니다.
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: CircleBorder(),
                                      minimumSize: Size(60, 60),
                                      elevation: 0,
                                      backgroundColor: Color(0xFFD9D9D9),
                                    ),
                                    child: Icon(
                                      Icons.circle,
                                      color: Color(0xFFD9D9D9),
                                      size: 24, // 아이콘의 크기 조절 가능
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    '정보&후기',
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 53),
                  SingleChildScrollView(
                    child: Container(
                      width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Color(0xFFE7E7E7),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  const SizedBox(height: 53),
                  Padding(
                    padding: const EdgeInsets.only(left: 19, right: 19),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '주목할 핫 플레이스',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: 'Segoe',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 25),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  'asset/img/img_place.png',
                                  width: 100, // 이미지 너비 조정
                                  height: 100, // 이미지 높이 조정
                                ),
                                SizedBox(width: 10), // 이미지와 텍스트 사이 간격 조정
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '주목할 핫플레이스',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontFamily: 'Segoe',
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      '위치 혹은 짧은 소개글',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontFamily: 'Segoe',
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  'asset/img/img_place.png',
                                  width: 100, // 이미지 너비 조정
                                  height: 100, // 이미지 높이 조정
                                ),
                                SizedBox(width: 10), // 이미지와 텍스트 사이 간격 조정
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '주목할 핫플레이스',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontFamily: 'Segoe',
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      '위치 혹은 짧은 소개글',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontFamily: 'Segoe',
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  'asset/img/img_place.png',
                                  width: 100, // 이미지 너비 조정
                                  height: 100, // 이미지 높이 조정
                                ),
                                SizedBox(width: 10), // 이미지와 텍스트 사이 간격 조정
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '주목할 핫플레이스',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontFamily: 'Segoe',
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      '위치 혹은 짧은 소개글',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontFamily: 'Segoe',
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 53),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      '코펫만의 핫딜',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Segoe',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Container(
                    width: double.infinity,
                    height: 100,
                    color: Color(0xFFE7E7E7),
                    //child: Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    //children: [
                    //HorizontalList(),
                    //],
                    //),
                  ),
                  const SizedBox(height: 53),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      '초특가 아이템',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Segoe',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  const SizedBox(height: 426),
                  const SizedBox(height: 100),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '코펫',
                          style: TextStyle(
                            fontFamily: 'Segeo',
                            fontSize: 15,
                            color: Color(0xFFAFAFAF),
                          ),
                        ),
                        Text(
                          '문의사항 코펫이메일@gmail.com',
                          style: TextStyle(
                            fontFamily: 'Segeo',
                            fontSize: 15,
                            color: Color(0xFFAFAFAF),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HorizontalList extends StatefulWidget {
  @override
  _HorizontalListState createState() => _HorizontalListState();
}

class _HorizontalListState extends State<HorizontalList> {
  final List<String> items = ['Item 1', 'Item 2', 'Item 3', 'Item 4', 'Item 5'];
  int currentIndex = 0;

  void moveRight() {
    setState(() {
      if (currentIndex < items.length - 1) {
        currentIndex++;
      } else {
        currentIndex = 0;
      }
    });
  }

  void moveLeft() {
    setState(() {
      if (currentIndex > 0) {
        currentIndex--;
      } else {
        currentIndex = items.length - 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back_ios),
              color: Color(0xFF717171),
              onPressed: moveLeft,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  items.length,
                  (index) => Container(
                    width: 60,
                    height: 60,
                    margin: index % 5 == 4
                        ? EdgeInsets.zero
                        : EdgeInsets.only(right: 3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: currentIndex == index ? Colors.grey : Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              color: Color(0xFF717171),
              onPressed: moveRight,
            ),
          ],
        ),
      ],
    );
  }
}
