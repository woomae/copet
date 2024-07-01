import 'package:flutter/material.dart';
import 'package:pet/login/login_main.dart';
import 'package:pet/main/main_home.dart';
import '../../const/taps.dart';
import 'main_screen.dart';

class mainscroll extends StatefulWidget {
  const mainscroll({Key? key}) : super(key: key);

  @override
  State<mainscroll> createState() => _mainscrollState();
}

class _mainscrollState extends State<mainscroll> with TickerProviderStateMixin {
  late final TabController controller;
  int currentIndex = 0;

  // 각 탭에 대한 화면 위젯 목록
  final List<Widget> tabScreens = [
    mainscreen(), // 첫 번째 탭에 대한 화면
    mainhome(), // 두 번째 탭에 대한 화면
    // 나머지 탭에 대한 화면 추가 가능
  ];

  @override
  void initState() {
    super.initState();
    controller = TabController(
      length: TABS.length,
      vsync: this,
    );
    controller.addListener(() {
      setState(() {
        currentIndex = controller.index;
      });
    });
  }

  // 이벤트 리스너 메서드
  void _onTabIndexChanged() {
    setState(() {}); // 화면 다시 그리기
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
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
          SingleChildScrollView(
            child: tabScreens[currentIndex],
          ),
        ],

      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
          controller.animateTo(index);
        },
        items: TABS
            .map(
              (e) => BottomNavigationBarItem(
            icon: Icon(
              e.icon,
            ),
            label: e.label,
          ),
        )
            .toList(),
      ),
    );
  }
}