import 'package:flutter/material.dart';
import 'package:pet/api/article/getArticles.dart';
import 'package:pet/common/component/widgets/silver_post_list.dart';
import 'package:pet/common/component/widgets/spinner_widget.dart';
import 'package:pet/const/models/articles.dart';
import 'package:pet/pages/community/post_list.dart';
import 'package:pet/pages/search/search_result.dart';

class result_community extends StatelessWidget {
  final String q;
  const result_community({super.key, required this.q});

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
              '커뮤니티 - 검색 결과',
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
          FutureBuilder<Articles>(future:GetArticles.getArticles(q: q), builder: (BuildContext context, snapshot){
            if(snapshot.hasError)
              return SliverToBoxAdapter(child: Center(child: Text('Error'),));
            if(snapshot.hasData){
              return SilverPostList(articles: snapshot.data!);
            }
            else
              return SliverToBoxAdapter(
                child: Center(child: SpinnerWidget()));
          })
        ],
      ),
    );
  }
}
