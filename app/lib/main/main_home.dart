import 'package:flutter/material.dart';
import 'package:pet/main/main_screen.dart';
import 'package:pet/style/colors.dart';
import '../../const/taps.dart';
import '../style/colors.dart';
import '../style/colors.dart';
import '../style/colors.dart'; // TABS를 정의하는 파일을 가져옵니다.

class TapItem {
  final String iconPath;
  final String selectedIconPath;
  final String label;

  TapItem({required this.iconPath, required this.selectedIconPath, required this.label});
}

class mainhome extends StatefulWidget {
  const mainhome({Key? key}) : super(key: key);

  @override
  State<mainhome> createState() => _mainhomeState();
}

class _mainhomeState extends State<mainhome> with TickerProviderStateMixin {
  late final TabController controller;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    controller = TabController(
      length: TABS.length,
      vsync: this,
    );
    controller.addListener(() {
      setState(() {
        selectedIndex = controller.index;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: TabBarView(
        controller: controller,
        children: TABS.map((e) =>
            Center(
              child: e.screen,
            )).toList(),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.transparent, // 전체 컨테이너의 색상을 설정
          boxShadow: [
            BoxShadow(
              color: Color(0x1A000000), // 투명도 10%의 검정색
              offset: Offset(0, -2), // x: 0, y: -2
              blurRadius: 4, // blur radius
              spreadRadius: 0, // spread radius
            ),
          ],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
          ),
        ),
        height: 98,
        child: SafeArea(
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
            child: Container(
              color: WHITE,
              height: 98, // 디바이스 높이에 맞추기
              child: BottomNavigationBar(
                elevation: 0,
                backgroundColor: WHITE,
                selectedItemColor: PRIMARY_COLOR,
                unselectedItemColor: Colors.grey,
                showSelectedLabels: true,
                showUnselectedLabels: true,
                currentIndex: selectedIndex,
                type: BottomNavigationBarType.fixed,
                onTap: (index) {
                  setState(() {
                    selectedIndex = index;
                    controller.animateTo(index);
                  });
                },
                items: TABS.map((e) {
                  final isSelected = selectedIndex == TABS.indexOf(e);
                  return BottomNavigationBarItem(
                    icon: Container(
                      width: double.infinity,
                      height: 98,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? PRIMARY_COLOR.withOpacity(0.1) // 선택된 항목의 배경 색상
                            : Colors.transparent, // 비선택 항목의 배경 색상
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(selectedIndex == 0 ? 20.0 : 0.0), // 첫 번째 항목의 왼쪽 위 테두리 반경
                          topRight: Radius.circular(selectedIndex == TABS.length - 1 ? 20.0 : 0.0), // 마지막 항목의 오른쪽 위 테두리 반경
                        ),
                        border: Border(
                          top: BorderSide(
                            color: isSelected ? PRIMARY_COLOR : Colors.transparent, // 선택된 항목의 상단 테두리 색상
                            width: 2, // 상단 테두리 두께
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              isSelected ? e.selectedIconPath : e.iconPath,
                              width: 25,
                              height: 25,
                            ),
                            SizedBox(height: 5),
                            Text(
                              e.label,
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'Segoe',
                                color: isSelected ? PRIMARY_COLOR : Color(0xFF959595),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    label: e.label,
                  );
                }).toList(),
                selectedLabelStyle: TextStyle( // 선택된 라벨 스타일
                  fontSize: 0,
                  fontFamily: 'Segoe',
                ),
                unselectedLabelStyle: TextStyle( // 선택되지 않은 라벨 스타일
                  fontSize: 0,
                  fontFamily: 'Segoe',
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  TapItem _convertToTapItem(TabInfo tabInfo) {
    return TapItem(iconPath: tabInfo.iconPath,
        selectedIconPath: tabInfo.selectedIconPath,
        label: tabInfo.label);
  }
}
