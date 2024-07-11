import 'package:flutter/material.dart';
import 'package:pet/main/main_screen.dart';
import 'package:pet/style/colors.dart';
import '../../const/taps.dart'; // TABS를 정의하는 파일을 가져옵니다.

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
      bottomNavigationBar: SafeArea(
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: Container(
            color: WHITE, // 전체 컨테이너의 색상을 설정
            height: 98, // 디바이스 높이에 맞추기
            child: BottomNavigationBar(
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
                    color: isSelected ? PRIMARY_COLOR.withOpacity(0.1) : Colors.transparent, // 투명도 추가
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
                  label: '',
                );
              }).toList(),
              selectedLabelStyle: TextStyle( // 선택된 라벨 스타일
                fontSize: 12,
                fontFamily: 'Segoe',
              ),
              unselectedLabelStyle: TextStyle( // 선택되지 않은 라벨 스타일
                fontSize: 12,
                fontFamily: 'Segoe',
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
  // Widget _buildTabContent(TapItem tab) {
  //   return CustomScrollView(
  //     slivers: [
  //       SliverAppBar(
  //         //titleSpacing: 0,
  //         automaticallyImplyLeading: false,
  //         backgroundColor: Colors.white,
  //         elevation: 0,
  //         title: Text(
  //           'COPET',
  //           style: TextStyle(
  //             fontFamily: 'Poetsen',
  //             color: Colors.black,
  //             fontSize: 25,
  //           ),
  //         ),
  //         centerTitle: false,
  //         flexibleSpace: FlexibleSpaceBar(
  //           background: Container(
  //             decoration: BoxDecoration(
  //               gradient: LinearGradient(
  //                 begin: Alignment.topCenter,
  //                 end: Alignment.bottomCenter,
  //                 colors: [
  //                   Colors.white.withOpacity(0), // 상단 투명 부분의 색상 (투명도 조절 가능)
  //                   Colors.white, // 하단 일반적인 흰색 배경
  //                 ],
  //                 stops: [0.0, 0.33], // 각 색상의 정지점 (0.0 ~ 1.0 사이 값)
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //       // SliverList(
  //       //   delegate: SliverChildBuilderDelegate(
  //       //     (context, index) {
  //       //       return renderContainer(
  //       //         color: Colors.white,
  //       //       );
  //       //     },
  //       //     childCount: 1,
  //       //   ),
  //       // ),
  //       // SliverList(
  //       //   delegate: SliverChildBuilderDelegate(
  //       //         (context, index) {
  //       //       return greyContainer(
  //       //         color: Colors.grey,
  //       //       );
  //       //     },
  //       //     childCount: 1,
  //       //   ),
  //       // ),
  //       // SliverList(
  //       //   delegate: SliverChildBuilderDelegate(
  //       //         (context, index) {
  //       //       return renderContainer(
  //       //         color: Colors.white,
  //       //       );
  //       //     },
  //       //     childCount: 1,
  //       //   ),
  //       // ),
  //       // SliverList(
  //       //   delegate: SliverChildBuilderDelegate(
  //       //         (context, index) {
  //       //       return greyContainer(
  //       //         color: Colors.grey,
  //       //       );
  //       //     },
  //       //     childCount: 1,
  //       //   ),
  //       // ),
  //       // SliverList(
  //       //   delegate: SliverChildBuilderDelegate(
  //       //         (context, index) {
  //       //       return renderContainer(
  //       //         color: Colors.white,
  //       //       );
  //       //     },
  //       //     childCount: 1,
  //       //   ),
  //       // ),
  //     ],
  //   );
  // }



  // Widget renderContainer({
  //   required Color color,
  // }) {
  //   return Container(
  //     height: 500,
  //     color: color,
  //   );
  // }
  //
  // Widget greyContainer({
  //   required Color color,
  // }) {
  //   return Container(
  //     height: 150,
  //     color: color,
  //   );
  // }

