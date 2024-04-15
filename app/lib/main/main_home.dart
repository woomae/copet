import 'package:flutter/material.dart';
import 'package:pet/main/main_screen.dart';
import 'package:pet/style/colors.dart';
import '../../const/taps.dart'; // TABS를 정의하는 파일을 가져옵니다.

class TapItem {
  final IconData icon;
  final String label;

  TapItem({required this.icon, required this.label});
}

class mainhome extends StatefulWidget {
  const mainhome({Key? key}) : super(key: key);

  @override
  State<mainhome> createState() => _mainhomeState();
}

class _mainhomeState extends State<mainhome> with TickerProviderStateMixin {
  late final TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(
      length: TABS.length,
      vsync: this,
    );
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: TabBarView(
        controller: controller,
        children:
            //TABS.map((e) => _buildTabContent(_convertToTapItem(e))).toList(),
            TABS.map((e) => Center(
              child: e.screen,
            )).toList()
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: WHITE,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: controller.index,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          controller.animateTo(index);
        },
        items: TABS.map(
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

  Widget _buildTabContent(TapItem tab) {
    return CustomScrollView(
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
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return renderContainer(
                color: Colors.white,
              );
            },
            childCount: 1,
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
                (context, index) {
              return greyContainer(
                color: Colors.grey,
              );
            },
            childCount: 1,
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
                (context, index) {
              return renderContainer(
                color: Colors.white,
              );
            },
            childCount: 1,
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
                (context, index) {
              return greyContainer(
                color: Colors.grey,
              );
            },
            childCount: 1,
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
                (context, index) {
              return renderContainer(
                color: Colors.white,
              );
            },
            childCount: 1,
          ),
        ),
      ],
    );
  }

  TapItem _convertToTapItem(TabInfo tabInfo) {
    return TapItem(icon: tabInfo.icon, label: tabInfo.label);
  }

  Widget renderContainer({
    required Color color,
  }) {
    return Container(
      height: 500,
      color: color,
    );
  }

  Widget greyContainer({
    required Color color,
  }) {
    return Container(
      height: 150,
      color: color,
    );
  }
}
