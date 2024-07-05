import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:pet/main/main_item.dart';

import 'main_place.dart';
import 'main_screen.dart';

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

class mainscreen extends StatelessWidget {
  const mainscreen({super.key});

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
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                'COPET',
                style: TextStyle(
                  fontFamily: 'Poetsen',
                  color: Colors.black,
                  fontSize: 25,
                ),
              ),
            ),
            centerTitle: false,
            actions: [
              InkWell(
                onTap: () {},
                child: Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Image.asset(
                    'asset/img/alarm.png', // 원하는 이미지의 경로
                    width: 18.0, // 이미지의 너비
                    height: 19.38, // 이미지의 높이
                  ),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Padding(
                  padding: EdgeInsets.only(right: 30),
                  child: Image.asset(
                    'asset/img/mail.png', // 원하는 이미지의 경로
                    width: 22.0, // 이미지의 너비
                    height: 16.5, // 이미지의 높이
                  ),
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 57, bottom: 65),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      children: [
                        WalkButton(
                          imagePath: 'asset/img/main/walk.png',
                          width: MediaQuery.of(context).size.width * 0.5 - 30,
                          height: 200,
                          onPressed: () {},
                        ),
                        const SizedBox(width: 20),
                        Column(
                          children: [
                            InkWell(
                              onTap: () {},
                              child: Container(
                                width:
                                    MediaQuery.of(context).size.width * 0.5 - 30,
                                height: 90,
                                decoration: BoxDecoration(
                                  color: Color(0xFFFBFBFB),
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 0,
                                      blurRadius: 4,
                                      offset: Offset(4, 4),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      '검색하기',
                                      style: TextStyle(
                                        color: Color(0xFFFFCB45),
                                        fontSize: 25,
                                        fontFamily: 'SnowCrap',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            InkWell(
                              onTap: () {},
                              child: Container(
                                width:
                                    MediaQuery.of(context).size.width * 0.5 - 30,
                                height: 90,
                                decoration: BoxDecoration(
                                  color: Color(0xFFFBFBFB),
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 0,
                                      blurRadius: 4,
                                      offset: Offset(4, 4), // 오른쪽과 아래쪽 그림자
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      '커뮤니티',
                                      style: TextStyle(
                                        color: Color(0xFFFFCB45),
                                        fontSize: 25,
                                        fontFamily: 'SnowCrap',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 20, 15, 50),
                    child: Container(
                      width: double.infinity,
                      height: 180,
                      decoration: BoxDecoration(
                        color: Color(0xFFFBFBFB),
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Color(0xFFF2F2F2),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      // 버튼이 클릭되었을 때 수행할 작업을 여기에 추가합니다.
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: CircleBorder(),
                                      minimumSize: Size(60, 60),
                                      elevation: 0,
                                      backgroundColor: Color(0xFFD9D9D9),
                                    ),
                                    child: Image.asset(
                                      'asset/img/main/daily.png',
                                      width: 60,
                                      height: 60,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    '일상',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontFamily: 'Segoe',
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      // 버튼이 클릭되었을 때 수행할 작업을 여기에 추가합니다.
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: CircleBorder(),
                                      minimumSize: Size(60, 60),
                                      elevation: 0,
                                      backgroundColor: Color(0xFFD9D9D9),
                                    ),
                                    child: Image.asset(
                                      'asset/img/main/QA.png',
                                      width: 60,
                                      height: 60,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    '도움',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontFamily: 'Segoe',
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      // 버튼이 클릭되었을 때 수행할 작업을 여기에 추가합니다.
                                    },
                                    style: ElevatedButton.styleFrom(
                                      shape: CircleBorder(),
                                      minimumSize: Size(60, 60),
                                      elevation: 0,
                                      backgroundColor: Color(0xFFD9D9D9),
                                    ),
                                    child: Image.asset(
                                      'asset/img/main/information.png',
                                      width: 60,
                                      height: 60,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    '정보&후기',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontFamily: 'Segoe',
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Container(
                      width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Color(0xFFE7E7E7),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.asset(
                          'asset/img/main/banner.png', // 이미지 경로
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover, // 이미지를 컨테이너에 맞추기 위해 사용
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(25, 60, 25, 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'HOT 게시글',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontFamily: 'NotoSansKR',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            MoreButton_hot(),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '주목할 핫 플레이스',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontFamily: 'NotoSansKR',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            MoreButton_place(),
                          ],
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
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '초특가 아이템',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontFamily: 'NotoSansKR',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            MoreButton_item(),
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
                    padding: const EdgeInsets.only(top: 100),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '코펫',
                            style: TextStyle(
                              fontFamily: 'Segeo',
                              fontSize: 15,
                              color: Color(0xFFAFAFAF),
                            ),
                          ),
                          Text(
                            '문의사항 코펫이메일@gmail.com',
                            style: TextStyle(
                              fontFamily: 'Segeo',
                              fontSize: 15,
                              color: Color(0xFFAFAFAF),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

    );
  }
}

// class HorizontalList extends StatefulWidget {
//   @override
//   _HorizontalListState createState() => _HorizontalListState();
// }
//
// class _HorizontalListState extends State<HorizontalList> {
//   final List<String> items = ['Item 1', 'Item 2', 'Item 3', 'Item 4', 'Item 5'];
//   int currentIndex = 0;
//
//   void moveRight() {
//     setState(() {
//       if (currentIndex < items.length - 1) {
//         currentIndex++;
//       } else {
//         currentIndex = 0;
//       }
//     });
//   }
//
//   void moveLeft() {
//     setState(() {
//       if (currentIndex > 0) {
//         currentIndex--;
//       } else {
//         currentIndex = items.length - 1;
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             IconButton(
//               icon: Icon(Icons.arrow_back_ios),
//               color: Color(0xFF717171),
//               onPressed: moveLeft,
//             ),
//             Expanded(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: List.generate(
//                   items.length,
//                   (index) => Container(
//                     width: 60,
//                     height: 60,
//                     margin: index % 5 == 4
//                         ? EdgeInsets.zero
//                         : EdgeInsets.only(right: 3),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(5),
//                       color: currentIndex == index ? Colors.grey : Colors.white,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             IconButton(
//               icon: Icon(Icons.arrow_forward_ios),
//               color: Color(0xFF717171),
//               onPressed: moveRight,
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

class WalkButton extends StatelessWidget {
  final String imagePath;
  final double width;
  final double height;
  final VoidCallback onPressed;

  const WalkButton({
    Key? key,
    required this.imagePath,
    required this.width,
    required this.height,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Image.asset(
        imagePath,
        width: width,
        height: height,
      ),
    );
  }
}

class MoreButton_hot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
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

class MoreButton_place extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const mainplace()),
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

class MoreButton_item extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const mainitem()),
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
