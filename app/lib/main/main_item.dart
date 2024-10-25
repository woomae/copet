import 'package:flutter/material.dart';
import 'main_home.dart';

class mainitem extends StatelessWidget {
  const mainitem({super.key});

  @override
  Widget build(BuildContext context) {
    List<Item> items = List.generate(
      15,
          (index) => Item(
        imagePath: 'asset/img/img_place.png',
        productName: '상품 ${index + 1}',
        price: '${(index + 1) * 5000}원',
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
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
                Navigator.pop(context);
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
          SliverPadding(
            padding: EdgeInsets.only(top: 20, left: 16, right: 16), // 상단, 좌측, 우측 여백
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // 한 줄에 3개의 아이템
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.55,
              ),
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return ItemCard(item: items[index]);
                },
                childCount: items.length, // 아이템 개수
              ),
            ),
          ),
        ],
      ),
    );
  }
}

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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.productName,
                    style: TextStyle(
                      color: Color(0xFF686868),
                      fontSize: 15,
                      fontFamily: 'NotoSansKR',
                      fontWeight: FontWeight.w400,
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
            ),
          ],
        ),
      ),
    );
  }
}
