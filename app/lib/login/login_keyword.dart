import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pet/common/component/keyword/keyword.dart';
import 'package:pet/login/login_end.dart';

import '../style/colors.dart';
import 'login_agree.dart';

class loginkeyword extends StatefulWidget {
  const loginkeyword({super.key});

  @override
  State<loginkeyword> createState() => _loginkeywordState();
}

class _loginkeywordState extends State<loginkeyword> {
  final Set<int> selectedIndexes = {};

  void onKeywordTap(int index) {
    setState(() {
      if (selectedIndexes.contains(index)) {
        selectedIndexes.remove(index);
      } else {
        if (selectedIndexes.length < 3) {
          selectedIndexes.add(index);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    int selectedCount = selectedIndexes.length;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                //titleSpacing: 0,
                automaticallyImplyLeading: false,
                backgroundColor: Colors.white,
                elevation: 0,
                pinned: true,
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
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white.withOpacity(0), // 상단 투명 부분의 색상 (투명도 조절 가능)
                          Colors.white, // 하단 일반적인 흰색 배경
                        ],
                        stops: [0.0, 0.33], // 각 색상의 정지점 (0.0 ~ 1.0 사이 값)
                      ),
                    ),
                  ),
                ),
                shape: Border(
                  bottom: BorderSide(color: Color(0xFFDEDEDE), width: 1.0),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(top: 50, bottom: 177),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _Title(),
                      const SizedBox(height: 20),
                      _SubTitle(),
                      const SizedBox(height: 20),
                      selectedcount(selectedCount: selectedCount),
                      //const SizedBox(height: 50),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 15,
                            childAspectRatio: 0.75,
                          ),
                          itemCount: keywords.length,
                          itemBuilder: (context, index) {
                            final keyword = keywords[index];
                            final isSelected = selectedIndexes.contains(index);

                            return GestureDetector(
                              onTap: () => onKeywordTap(index),
                              child: Column(
                                children: [
                                  Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      ClipOval(
                                        child: Image.asset(
                                          keyword.imagePath,
                                          fit: BoxFit.cover,
                                          width: 100,
                                          height: 100,
                                        ),
                                      ),
                                      if (isSelected)
                                        ClipOval(
                                          child: Container(
                                            width: 100,
                                            height: 100,
                                            color: Colors.black.withOpacity(0.2),
                                            child: Center(
                                              child: Image.asset(
                                                'asset/img/check_white.png',
                                                width: 50,
                                                height: 36.72,
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                  Text(
                                    keyword.name,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Segoe',
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: 177,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white.withOpacity(0), // 상단 투명 부분의 색상 (투명도 조절 가능)
                    Colors.white, // 하단 일반적인 흰색 배경
                  ],
                  stops: [0.0, 0.33], // 각 색상의 정지점 (0.0 ~ 1.0 사이 값)
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: nextbutton_keyword(),
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
    return Padding(
      padding: const EdgeInsets.only(left: 30),
      child: Text(
        '키워드 선택',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          fontFamily: 'Segoe',
          color: Colors.black,
        ),
      ),
    );
  }
}

class _SubTitle extends StatelessWidget {
  const _SubTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30),
      child: Text(
        '키워드를 선택해서 나와 반려동물에게\n더 잘 맞는 친구를 찾아보세요!',
        style: TextStyle(
          fontSize: 15,
          fontFamily: 'Segoe',
          color: Colors.black,
        ),
      ),
    );
  }
}

class selectedcount extends StatelessWidget {
  final int selectedCount;
  const selectedcount({super.key, required this.selectedCount});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30),
      child: Text(
        '$selectedCount/3', // 체크된 개수 표시
        style: TextStyle(
          fontSize: 15,
          fontFamily: 'Segoe',
          color: Color(0xFF686868),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class nextbutton_keyword extends StatelessWidget {
  const nextbutton_keyword({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 40),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const loginend()),
            );
          },
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
      ),
    );
  }
}
