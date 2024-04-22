import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet/style/colors.dart';

import '../../const/models/articles.dart';

class PostList extends StatelessWidget {
  final int length;
  final List<Comments> comments;
  const PostList({
    super.key,
    required this.length,
    required this.comments
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: length,
        itemBuilder: (BuildContext context, int i) {
          //썸네일, 작성자, 제목, 작성일,스크랩 여부,
          return GestureDetector(
            onTap: (){
              print('Posting Pressed');
            },
            child: Container(
              color: WHITE,
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
              child: Row(
                children: [
                  //글 이미지..?
                  Container(
                    margin: EdgeInsets.only(right: 5),
                    width: 45,
                    height: 45,
                    decoration: BoxDecoration(
                        color: GREY2,
                        borderRadius: BorderRadius.circular(10)
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(comments[i].title! , style: Theme.of(context).textTheme.bodyMedium,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(comments[i].author!),
                              Row(
                                children: [
                                  Text('날짜'),
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
          );;
        });
  }
}


