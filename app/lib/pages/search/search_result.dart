import 'package:flutter/material.dart';
import 'package:pet/api/article/getArticles.dart';
import 'package:pet/api/mocks/getPetItems.dart';
import 'package:pet/common/component/widgets/pet_items_list.dart';
import 'package:pet/common/component/widgets/pet_place_list.dart';
import 'package:pet/const/models/articles.dart';
import 'package:pet/const/models/merchandises.dart';
import 'package:pet/const/models/pet_place.dart';
import 'package:pet/pages/community/post_list.dart';
import 'package:pet/pages/search/search_community.dart';
import 'package:pet/pages/search/search_item.dart';
import 'package:pet/pages/search/search_place.dart';
import 'package:pet/style/colors.dart';

import '../../api/mocks/getPetPlace.dart';
import '../../utils/format_date.dart';

class Item {
  final String imagePath;
  final String productName;
  final String price;

  Item({
    required this.imagePath,
    required this.productName,
    required this.price,
  });
}

class result extends StatelessWidget {
  final String q;
  const result({super.key, required this.q});

  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  FutureBuilder<Articles>(
                    future: GetArticles.getArticles(q: q, size: 2),
                    builder: (BuildContext context, snapshot){
                      if(snapshot.hasError)
                        return SizedBox();
                      if(snapshot.hasData){
                        final data = snapshot.data;
                        return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.fromLTRB(25, 0, 25, 24),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '검색 결과 - 게시판',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 22,
                                        fontFamily: 'NotoSansKR',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder:
                                            (context) => result_community(q: q,)),
                                      );
                                    },
                                    style: TextButton.styleFrom(
                                      foregroundColor: Color(0xFFD9D9D9), backgroundColor: Colors.white,
                                      textStyle: TextStyle(
                                        fontFamily: 'NotoSansKR',
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15,
                                      ),
                                    ),
                                    child: Text('더보기'),
                                    ),
                                  ],
                                ),
                              ),
                              Column(children: data!.article.map((e){
                                return
                                  PostContainer(
                                    nickname: e.author,
                                      postedTime: formatDateToYYYYMMDD(e.createdAt!),
                                      postTitle: e.title);
                              }).toList(),)
                            ],
                          );
                      }
                      else
                        return SizedBox();
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 55, 20, 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '검색 결과 - 플레이스',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontFamily: 'NotoSansKR',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              MoreButton_result_place(),
                            ],
                          ),
                        ),
                        const SizedBox(height: 25),
                        FutureBuilder<PetPlaces>(future: getPetPlace(), builder: (BuildContext context, snapshot){
                          if(snapshot.hasError) {
                            print(snapshot.error);
                            return SizedBox();
                          }
                          if(snapshot.hasData){
                            return PetPlaceList(petPlaces: snapshot.data!, length: 3);
                          }
                          else{
                            return SizedBox();
                          }
                        })
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '검색 결과 - 아이템',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontFamily: 'NotoSansKR',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            MoreButton_result_item(),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: FutureBuilder(future: getPetItems(), builder: (context, snapshot){
                          if(snapshot.hasError){
                            print(snapshot.error);
                            return Center(child: Text('error'));
                          }
                          if(snapshot.hasData){
                            return PetItemsList(merchandises: snapshot.data!, length: 6);
                          }
                          else
                            return SizedBox();
                        })
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 100, bottom: 85),
                    child: Center(
                      child: Text(
                        '코펫\n문의사항 코펫이메일@gmail.com',
                        style: TextStyle(
                          fontFamily: 'Segeo',
                          fontSize: 15,
                          color: Color(0xFFAFAFAF),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
    );

  }
}

class searchbar_result extends StatelessWidget {
  const searchbar_result({super.key});

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
            onPressed: () {

            },
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

class PostContainer extends StatelessWidget {
  final String nickname;
  final String postedTime;
  final String postTitle;

  const PostContainer({
    Key? key,
    required this.nickname,
    required this.postedTime,
    required this.postTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 25),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Color(0xFFF3F3F3),
              width: 1.0,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 15, 16, 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    nickname,
                    style: TextStyle(
                      color: Color(0xFF919191),
                      fontSize: 12.0,
                      fontFamily: 'NotoSansKR',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    postedTime,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Color(0xFFD9D9D9),
                      fontFamily: 'Segoe',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6.0),
              Text(
                postTitle,
                style: TextStyle(
                  color: Color(0xFF4C4C4C),
                  fontSize: 14.0,
                  fontFamily: 'NotoSansKR',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MoreButton_result_place extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const result_place()),
        );
      },
      style: TextButton.styleFrom(
        foregroundColor: Color(0xFFD9D9D9), backgroundColor: Colors.white,
        textStyle: TextStyle(
          fontFamily: 'NotoSansKR',
          fontWeight: FontWeight.w400,
          fontSize: 15,
        ),
      ),
      child: Text('더보기'),
    );
  }
}

class MoreButton_result_item extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const result_item()),
        );
      },
      style: TextButton.styleFrom(
        foregroundColor: Color(0xFFD9D9D9), backgroundColor: Colors.white,
        textStyle: TextStyle(
          fontFamily: 'NotoSansKR',
          fontWeight: FontWeight.w400,
          fontSize: 15,
        ),
      ),
      child: Text('더보기'),
    );
  }
}

class ItemCard extends StatelessWidget {
  final Merchandise item;

  const ItemCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      InkWell(
      onTap: () {
        // 아이템을 탭했을 때의 동작 정의
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(
                item.imgName,
                width: double.infinity,
                height: 144,
                fit: BoxFit.cover,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 7),
                  child: Text(
                    item.name,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Color(0xFF686868),
                      fontSize: 15,
                      fontFamily: 'NotoSansKR',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Text(
                  "25,000",
                  style: TextStyle(
                    color: Color(0xFF222222),
                    fontSize: 16,
                    fontFamily: 'Segoe',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}