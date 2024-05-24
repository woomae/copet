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
          return GestureDetector(
            onTap: (){
              print('Posting Pressed');
            },
            child: Container(
              decoration: BoxDecoration(
                  color: WHITE,
                border: Border(bottom: BorderSide(width: 1,color: GREY3))
              ),
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 18),
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(),
                                child: Row(children: [
                                  Text('[${comments[i].category}]', style: TextStyle(
                                      color: CATEGORY_COLOR
                                  ),),
                                  SizedBox(width: 5,),
                                  Expanded(
                                    child: Text(comments[i].title!,
                                      style: Theme.of(context).textTheme.titleMedium,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,),
                                  ),
                                ],),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(comments[i].author!, style: Theme.of(context).textTheme.bodySmall,),

                                  comments[i].createdAt!.year != DateTime.now().year ?
                                  Text('${DateTime.now().year - comments[i].createdAt!.year}년 전' ,style: TextStyle(color: FONT_GREY),) :
                                  comments[i].createdAt!.month != DateTime.now().month ?
                                  Text('${DateTime.now().month- comments[i].createdAt!.month}달 전' ,style: TextStyle(color: FONT_GREY),) :
                                  comments[i].createdAt!.day != DateTime.now().day ?
                                  Text('${DateTime.now().day - comments[i].createdAt!.day}일 전' ,style: TextStyle(color: FONT_GREY),) :
                                  comments[i].createdAt!.minute != DateTime.now().minute ?
                                  Text('${DateTime.now().minute - comments[i].createdAt!.minute}분 전' ,style: TextStyle(color: FONT_GREY),) :
                                      Text('방금 전'),
                                ],
                              )
                            ],),
                        ),
                        SizedBox(width: 5),
                        Row(
                          children: [
                            //글 이미지..?
                            // comments[i].imgName != null ?
                            //   Text(comments[i].imgName![0].toString()) :
                            comments[i].imgName != null && comments[i].imgName != '' ?
                            Container(width: 50, height: 50,color: Colors.black,) :
                            Thumbnail(),

                            Container(
                              margin: EdgeInsets.only(right: 5),
                              width: 40,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: GREY1,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(width: 1, color: GREY1)
                              ),
                              child: Column(
                                children: [
                                  Text('댓글', style: Theme.of(context).textTheme.bodyMedium,),
                                  Text(comments[i].commentCount.toString(),style: Theme.of(context).textTheme.bodyMedium,)
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );;
        });
  }
}

class Thumbnail extends StatelessWidget {
  const Thumbnail ({super.key});

  @override
  Widget build(BuildContext context) {
    Widget Line = Container(
      width: 25, height: 3,
      margin: EdgeInsets.only(bottom: 3),
      decoration: BoxDecoration(
          color: GREY3,
          borderRadius: BorderRadius.circular(30)
      ),
    );

    return Container(
      margin: EdgeInsets.only(right: 5),
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      width: 50,
      height: 50,
      decoration: BoxDecoration(
          color: GREY1,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 1, color: GREY2)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Line,
          Line,
          Container(
            width: 15, height: 3,
            decoration: BoxDecoration(
                color: GREY3,
                borderRadius: BorderRadius.circular(30)
            ),
          ),
        ],
      ),
    );

  }
}
