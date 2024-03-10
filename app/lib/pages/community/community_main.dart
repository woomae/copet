import 'package:flutter/material.dart';
import 'package:pet/common/component/appbar.dart';

//ListView.builder 활용해서 무한스크롤 구현?
class Community extends StatelessWidget {
  const Community({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return MaterialApp(
      home: Scaffold(
        appBar: Appbar(),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 60, bottom: 20, left: 10, right: 10),
              decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 1, color: Colors.black.withOpacity(0.2))
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                Category(categoryName: '일상'),
                Category(categoryName: '도움'),
                Category(categoryName: 'QnA'),
                Category(categoryName: '정보&후기'),
              ],),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 15,
                itemBuilder: (BuildContext context, int index) {
                  //썸네일, 작성자, 제목, 작성일, /스크랩 여부..?,좋아요 여부,,?,
                  return Post();
                },),
            )
          ],
        )
      ),
    );
  }
}
class Post extends StatelessWidget {
  const Post({super.key});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: (){
        print('Posting Pressed');
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: 5),
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10)
              ),
            ),
            Expanded(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text('제목', style: Theme.of(context).textTheme.bodyMedium,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('닉네임'),
                      Row(
                        children: [
                          Text('작성일'),
                          GestureDetector(
                            onTap: (){},
                              child: Icon(Icons.star_outline))
                        ],
                      )

                    ],
                  )
                ],),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class Category extends StatelessWidget {
  final String categoryName;
  const Category({
    super.key,
    required this.categoryName
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: GestureDetector(
        onTap: (){
          print('Category Pessed');},
        child: Column(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                color: Colors.grey,
                shape: BoxShape.circle
              ),
            ),
            Text(categoryName, style: Theme.of(context).textTheme.bodyMedium)
          ],
        ),
      ),
    );
  }
}


