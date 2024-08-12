import 'package:flutter/material.dart';

class mainsearch extends StatelessWidget {
  const mainsearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            'COPET',
            style: TextStyle(
              fontFamily: 'Poetsen',
              color: Colors.black,
              fontSize: 25,
              letterSpacing: -1,
            ),
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 50, 15, 100),
              child: searchbar(),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: _Title(),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 14),
              child: recentsearchlist(),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 40),
              child: _Title2(),
            ),
            PopularSearches(),
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: ask(),
            ),
          ],
        ),
      ),
    );
  }
}

class searchbar extends StatelessWidget {
  const searchbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 45,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Color(0xFF222222),
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
                left: 20, right: 50), // 오른쪽 여백을 버튼 크기만큼 추가
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          bottom: 0,
          right: 0,
          child: IconButton(
            onPressed: () {},
            icon: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Image.asset(
                'asset/img/search/searchicon.png',
                width: 30, // 이미지 너비
                height: 30, // 이미지 높이
                color: Colors.grey[700], // 이미지 색상
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      '최근 검색 기록',
      style: TextStyle(
        fontFamily: 'Segoe',
        fontSize: 16,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class recentsearchlist extends StatefulWidget {
  const recentsearchlist({Key? key});

  @override
  State<recentsearchlist> createState() => _recentsearchlistState();
}

class _recentsearchlistState extends State<recentsearchlist> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 가상의 최근 검색어 목록
    List<String> recentSearches = [
      '애견 호텔',
      '애견',
      '호텔',
      '애견호텔',
      '애견호텔호텔',
    ];

    return Scrollbar(
      thumbVisibility: true, // 스크롤바가 항상 보이도록 설정
      controller: _scrollController,
      thickness: 3.0, // 스크롤바의 두께 설정
      radius: Radius.circular(5),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        controller: _scrollController,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: Row(
            children: recentSearches.map((search) {
              return Padding(
                padding: const EdgeInsets.only(right: 10),
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white, // 버튼 배경색
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                    side: BorderSide(
                        color: Color(0xFFB0B0B0), width: 0.5), // 버튼 테두리 색상 및 두께
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 0, // 그림자 효과 제거
                  ).copyWith(
                    overlayColor: MaterialStateProperty.all(
                        Colors.transparent), // 스플래시 효과 제거,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        search,
                        style: TextStyle(
                          fontFamily: 'Segoe',
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 5), // 텍스트와 아이콘 사이의 간격
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            recentSearches.remove(search);
                          });
                        },
                        child: Icon(Icons.close,
                            size: 18, color: Color(0xFFB0B0B0)),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class _Title2 extends StatelessWidget {
  const _Title2({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      '인기 검색어',
      style: TextStyle(
        fontFamily: 'Segoe',
        fontSize: 16,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class PopularSearches extends StatelessWidget {
  final List<String> popularSearches = [
    '애견 호텔',
    '유기견 봉사 활동',
    '치약 간식',
    '임시보호',
    '입양',
    '산책',
    '골든리트리버',
    '고슴도치',
    '내게 맞는 동물은?',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, top: 10),
      child: Wrap(
        spacing: 10.0, // 버튼들 간의 간격 설정
        runSpacing: 10.0, // 줄 간의 간격 설정
        children: popularSearches.map((search) {
          return OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.white, // 버튼 배경색
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              side: BorderSide(
                color: Color(0xFFB0B0B0),
                width: 0.5,
              ), // 버튼 테두리 색상 및 두께
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 0, // 그림자 효과 제거
            ).copyWith(
              overlayColor: MaterialStateProperty.all(Colors.transparent),
            ),
            child: Text(
              search,
              style: TextStyle(
                fontFamily: 'Segoe',
                fontSize: 15,
                color: Colors.black,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class ask extends StatelessWidget {
  const ask({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '코펫\n문의사항 코펫이메일@gmail.com',
        style: TextStyle(
          fontFamily: 'Segeo',
          fontSize: 15,
          color: Color(0xFFAFAFAF),
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
