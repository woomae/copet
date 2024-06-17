import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet/api/getComments.dart';
import 'package:pet/common/component/appbars/go_back_appbar.dart';
import 'package:pet/const/models/comments_model.dart';
import 'package:pet/style/colors.dart';

import '../../api/getArticles.dart';
import '../../const/models/articles.dart';


class ArticlePage extends StatelessWidget {
  final int articleId;
  const ArticlePage({super.key, required this.articleId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GoBackAppBar(),
      body: Container(
        color: WHITE,
        child: Flex(
          direction: Axis.vertical,
          children: [
            FutureBuilder<Article>(
                future: GetArticles.getSingleArticle(articleId: articleId.toString()),
                builder: (context, snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return SizedBox(
                      height: 200,
                        child: Center(child: Text('로딩 중')));
                    // 로딩 중....
                  }
                  if(snapshot.hasData){
                    final Article data = snapshot.data!;
                    return Column(
                      children: [
                        _Title(titleText: data.title, nickname: data.author, postDate: '24.01.01'),
                        BodyText(bodyText: data.body, count: data.commentCount, scrap: data.scrapCount,),

                      ],
                    );
                  }
                  else{
                    //에러 처리
                    return SizedBox(
                        height: 200,
                        child: Center(child: Text('error')));
                  }
                }),
            FutureBuilder<Comments>(
                future: GetComments.getComments(id: articleId),
                builder: (context, snapshot){
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Center(child: Text('로딩 중'));
                    // 로딩 중....
                  }
                  if(snapshot.hasData){
                    final Comments data = snapshot.data!;
                    return BodyComments(
                      count: data.count,
                      comments : data.comments);
                  }
                  else{
                    //에러 처리
                    return Center(child: Text('error'));
                  }
                }),
          ],
        )
      ),
    );
  }
}
class _Title extends StatelessWidget {
  final String titleText;
  final String nickname;
  final String postDate;

  const _Title(
      {super.key, required this.titleText, required this.nickname, required this.postDate});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: WHITE,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(titleText, style: Theme.of(context).textTheme.titleLarge,),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(nickname, style: Theme.of(context).textTheme.labelMedium,),
                    SizedBox(width: 20),
                    Text(postDate, style: Theme.of(context).textTheme.labelMedium,)
                  ],
                ),
                Text(':')
            ],),
          ],
        ),
      ),
    );
  }
}
class BodyText extends StatelessWidget {
  final String bodyText;
  final int count;
  final int scrap;
  const BodyText({super.key, required this.bodyText, required this.count, required this.scrap});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minHeight: 120
      ),
      child: Column(
        children: [
          Container(
            alignment: AlignmentDirectional.topStart,
            width: double.infinity,
            decoration: BoxDecoration(
                color: WHITE,
                border: Border.symmetric(horizontal: BorderSide(width: 1, color: GREY))
            ),
            child:
              Padding(
                padding: EdgeInsets.all(20),
                  child: Text(bodyText, style: Theme.of(context).textTheme.bodyMedium,)),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 25
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text('댓글 $count', style: Theme.of(context).textTheme.labelMedium,),
                    SizedBox(width: 20),
                    Text('저장 $scrap', style: Theme.of(context).textTheme.labelMedium,)
                  ],
                ),
                IconButton(onPressed: (){}, icon: Icon(Icons.star_outline), color: GREY2)
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BodyComments extends StatelessWidget {
  final int count;
  final List<Comment> comments;
  const BodyComments({super.key, required this.count,required this.comments});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: WHITE,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: WHITE,
              border: Border(top: BorderSide(width: 5, color: GREY))
            ),
            child: SizedBox(height: 5,width: double.infinity,),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: comments.length,
            itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: WHITE,
                    border: Border(bottom: BorderSide(width: 1, color: GREY2))
                    ),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Row(
                    children: [
                      Text(comments[index].nickname, style: Theme.of(context).textTheme.bodyLarge,),
                      SizedBox(width: 5,),
                      Text('댓글 작성일', style: Theme.of(context).textTheme.labelMedium,)
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(comments[index].comment, style: Theme.of(context).textTheme.bodyMedium,)
                  ],
                  ),
                ),
              ],
              );
            },
          )
        ],
      ),
    );
  }
}




