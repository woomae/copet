import 'package:flutter/material.dart';
import 'package:pet/pages/search/search_result.dart';

class result_item extends StatelessWidget {
  const result_item({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            pinned: true,
            elevation: 0,
            title: Text(
              '상품 - 검색 결과',
              style: TextStyle(
                fontFamily: 'Segoe',
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: IconButton(
              icon: Icon(
                Icons.navigate_before,
                color: Colors.black,
              ),
              iconSize: 40,
              onPressed: () {
                Navigator.pop(context); // 뒤로 가기 기능
              },
            ),
            centerTitle: true, // title을 가운데 정렬
            titleSpacing: 0, // 좌우 여백 없앰
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
