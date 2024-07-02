import 'package:flutter/material.dart';

import 'main_home.dart';

class mainitem extends StatelessWidget {
  const mainitem({super.key});

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
            title: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Align(
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
                  MaterialPageRoute(builder: (context) => const mainhome()),
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
        ],
      ),
    );
  }
}
