import 'package:flutter/material.dart';
import 'package:pet/pages/search/search_community.dart';
import 'package:pet/pages/search/search_item.dart';
import 'package:pet/pages/search/search_place.dart';

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
  const result({super.key});

  @override
  Widget build(BuildContext context) {

    List<Item> items = [
      Item(
        imagePath: 'asset/img/img_place.png',
        productName: '상품 1',
        price: '10,000원',
      ),
      Item(
        imagePath: 'asset/img/img_place.png',
        productName: '상품 2',
        price: '15,000원',
      ),
      Item(
        imagePath: 'asset/img/img_place.png',
        productName: '상품 3',
        price: '20,000원',
      ),
      Item(
        imagePath: 'asset/img/img_place.png',
        productName: '상품 4',
        price: '25,000원',
      ),
      Item(
        imagePath: 'asset/img/img_place.png',
        productName: '상품 5',
        price: '30,000원',
      ),
      Item(
        imagePath: 'asset/img/img_place.png',
        productName: '상품 6',
        price: '35,000원',
      ),
    ];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            elevation: 0,
            title: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                'COPET',
                style: TextStyle(
                  fontFamily: 'Poetsen',
                  color: Colors.black,
                  fontSize: 25,
                  letterSpacing: -1,
                ),
              ),
            ),
            centerTitle: false,
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 50, 15, 35),
                  child: searchbar_result(),
                ),
                Column(
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
                          MoreButton_result_community(),
                        ],
                      ),
                    ),
                    PostContainer(
                      nickname: '닉네임',
                      postedTime: '2024.01.01',
                      postTitle: '게시글 이름입니다. 게시글이름입니다.',
                    ),
                    const SizedBox(height: 3),
                    PostContainer(
                      nickname: '닉네임',
                      postedTime: '2024.01.01',
                      postTitle: '게시글 이름입니다. 게시글이름입니다.',
                    ),
                  ],
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
                      InkWell(
                        onTap: () {},
                        child: Container(
                          child: Row(
                            children: [
                              Image.asset(
                                'asset/img/img_place.png',
                                width: 100, // 이미지 너비 조정
                                height: 100, // 이미지 높이 조정
                              ),
                              SizedBox(width: 15), // 이미지와 텍스트 사이 간격 조정
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '검색 결과 단어',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontFamily: 'NotoSansKR',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    '위치 혹은 짧은 소개글',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFFC9C9C9),
                                      fontFamily: 'NotoSansKR',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          child: Row(
                            children: [
                              Image.asset(
                                'asset/img/img_place.png',
                                width: 100, // 이미지 너비 조정
                                height: 100, // 이미지 높이 조정
                              ),
                              SizedBox(width: 15), // 이미지와 텍스트 사이 간격 조정
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '검색 결과 단어',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontFamily: 'NotoSansKR',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    '위치 혹은 짧은 소개글',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFFC9C9C9),
                                      fontFamily: 'NotoSansKR',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          child: Row(
                            children: [
                              Image.asset(
                                'asset/img/img_place.png',
                                width: 100, // 이미지 너비 조정
                                height: 100, // 이미지 높이 조정
                              ),
                              SizedBox(width: 15), // 이미지와 텍스트 사이 간격 조정
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '검색 결과 단어',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontFamily: 'NotoSansKR',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    '위치 혹은 짧은 소개글',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFFC9C9C9),
                                      fontFamily: 'NotoSansKR',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
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
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 25,
                          childAspectRatio: 0.55,
                        ),
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          return ItemCard(
                            item: items[index],
                          );
                        },
                      ),
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
            onPressed: () {},
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

class MoreButton_result_community extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const result_community()),
        );
      },
      style: TextButton.styleFrom(
        primary: Color(0xFFD9D9D9),
        backgroundColor: Colors.white,
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
        primary: Color(0xFFD9D9D9),
        backgroundColor: Colors.white,
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
        primary: Color(0xFFD9D9D9),
        backgroundColor: Colors.white,
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
  final Item item;

  const ItemCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
              child: Image.asset(
                item.imagePath,
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
                    item.productName,
                    style: TextStyle(
                      color: Color(0xFF686868),
                      fontSize: 15,
                      fontFamily: 'NotoSansKR',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Text(
                  item.price,
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