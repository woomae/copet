import 'package:flutter/material.dart';
import 'package:pet/login/login_main.dart';
import '../../const/taps.dart';

class maintabbar extends StatefulWidget {
  const maintabbar({super.key});

  @override
  State<maintabbar> createState() => _maintabbarState();
}

class _maintabbarState extends State<maintabbar> with TickerProviderStateMixin {
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
          children: TABS
              .map(
                (e) => Center(
                  child: Icon(e.icon)
                ),
              )
              .toList()),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        currentIndex: controller.index,
        type: BottomNavigationBarType.fixed,
        onTap: (index){
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
