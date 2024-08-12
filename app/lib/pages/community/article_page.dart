import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet/api/article/deleteArticle.dart';
import 'package:pet/api/article/deleteComment.dart';
import 'package:pet/api/article/getComments.dart';
import 'package:pet/api/article/patchComment.dart';
import 'package:pet/api/article/postComment.dart';
import 'package:pet/api/article/postLikeRequest.dart';
import 'package:pet/common/component/appbars/go_back_appbar.dart';
import 'package:pet/common/component/dialogs/confirmDialog.dart';
import 'package:pet/common/component/widgets/spinner_widget.dart';
import 'package:pet/const/models/comments_model.dart';
import 'package:pet/pages/community/article_edit_page.dart';
import 'package:pet/pages/community/posting_page.dart';
import 'package:pet/providers/posting_notifier_provider.dart';
import 'package:pet/providers/user_notifier_provider.dart';
import 'package:pet/style/colors.dart';

import '../../api/article/getArticles.dart';
import '../../const/models/articles.dart';
import '../../utils/format_date.dart';


class ArticlePage extends StatelessWidget {
  final int articleId;
  ArticlePage({super.key, required this.articleId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WHITE,
      resizeToAvoidBottomInset: true,
      appBar: GoBackAppBar(),
      body: FutureBuilder<Article>(
        future: GetArticles.getSingleArticle(articleId: articleId.toString()),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: SizedBox(
              width: 50, height: 50,
              child: SpinnerWidget(),
            ));
          }
          if(snapshot.hasData){
            final Article data = snapshot.data;
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    primary: false,
                    child: Container(
                      color: WHITE,
                      child: Column(
                        children: [
                          _Title(article: data,),
                          //_Title(titleText: data.title, nickname: data.author, postDate: '24.01.01'),
                          BodyText(article: data),
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
                                      comments : data.comments
                                  );
                                }
                                else{
                                  //에러 처리
                                  return Center(child: Text('error'));
                                }
                              }),
                        ],
                      ),
                    ),
                  ),
                ),
                _bottomInputBar(articleId: data.id.toString(),)
              ],
            );
          }
          else{
            return SizedBox();
          }
        },)
    );
  }
}
class _bottomInputBar extends StatelessWidget {
  final String articleId;
  const _bottomInputBar({super.key, required this.articleId});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();
    return BottomAppBar(
      padding: EdgeInsets.all(0),
      color: WHITE,
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          decoration: BoxDecoration(
              border: Border(top: BorderSide(width: 1, color: GREY2)),
              color: WHITE
          ),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: '댓글을 입력하세요',
                    border: InputBorder.none, // 밑줄 없앰
                    enabledBorder: InputBorder.none, // 밑줄 없앰
                    focusedBorder: InputBorder.none, // 밑줄 없앰
                    errorBorder: InputBorder.none, // 밑줄 없앰
                    disabledBorder: InputBorder.none,
                  ),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: PRIMARY_COLOR2,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: IconButton(
                  icon: Icon(Icons.arrow_outward, color: WHITE,),
                  onPressed: () {
                    PostComment.postComment(articleId: articleId, comment: _controller.text);
                    _controller.text = '';
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                ),
              ),
            ],
          )),
    );
  }
}

class _EditWidget extends StatelessWidget {
  final String buttonText1;
  final String buttonText2;
  final Function onPressedFn1;
  final Function onPressedFn2;
  const _EditWidget({
    super.key,
    required this.buttonText1,
    required this.buttonText2,
    required this.onPressedFn1,
    required this.onPressedFn2});

  @override
  Widget build(BuildContext context) {

     return Theme(
       data: Theme.of(context).copyWith(
         highlightColor: Colors.transparent,
         splashColor: Colors.transparent
       ),
       child: PopupMenuButton(
          color: WHITE,
           surfaceTintColor: Colors.transparent,
           padding: EdgeInsets.all(0),
            iconColor: GREY2,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                side:BorderSide(width: 1, color: WHITE)
            ),
            itemBuilder: (context){
              return [
                PopupMenuItem(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      Text(buttonText1, style: TextStyle(color: WARNING,),),
                      Icon(Icons.restore_from_trash_outlined, color: WARNING,)
                    ],),
                    onTap: (){
                      onPressedFn1();
                    }
                ),
                PopupMenuItem(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(buttonText2),
                      Icon(Icons.edit)
                    ],
                  ),
                  onTap: (){
                    onPressedFn2();
                  },
                )
              ];
            }),
     );;
  }
}

class _Title extends StatefulWidget {

  final Article article;

  const _Title(
      {super.key, required this.article});

  @override
  State<_Title> createState() => _TitleState();
}

class _TitleState extends State<_Title> {

  @override
  Widget build(BuildContext context) {
    final category = widget.article.category;
    final DateTime? date = widget.article.createdAt;
    String formattedDate = '${date?.year}.${date?.month.toString().padLeft(2, '0')}.${date?.day.toString().padLeft(2, '0')}';

    return Container(
      color: WHITE,
      child: Padding(
        padding: const EdgeInsets.only(right: 20, left: 20, top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Text('[$category]', style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: CATEGORY_COLOR
              )),
              SizedBox(width: 5),
              Text(widget.article.title, style: Theme.of(context).textTheme.titleLarge,),
            ]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(widget.article.author, style: Theme.of(context).textTheme.labelMedium,),
                    SizedBox(width: 20),
                    Text(formattedDate, style: Theme.of(context).textTheme.labelMedium,)
                  ],
                ),
                  Consumer(
                    builder: (BuildContext context, WidgetRef ref, Widget? child) {
                      final state = ref.read(UserProvider);
                      if(state.nickname == widget.article.author)
                      return _EditWidget(
                        buttonText1: '게시물 삭제', buttonText2: '글 수정',
                        onPressedFn1: () async {
                          //게시물 삭제
                          bool confirmed = await confirmDialog(context);
                          if (confirmed) {
                            // 수락(Confirm) 버튼을 눌렀을 때의 로직
                            DeleteArticle.deleteArticle(widget.article.id.toString());
                          } else {
                            // 취소(Cancel) 버튼을 눌렀을 때의 로직
                            return null;
                          }
                        },
                        onPressedFn2: (){
                          //게시물 수정

                          ref.read(PostingProvider.notifier).updatePosting(
                            title: widget.article.title,
                            body: widget.article.body,
                            category: widget.article.category,
                            imageFiles: widget.article.photos
                          );
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>
                              ArticleEditPage(articleId: widget.article.id.toString())));
                        },
                      );
                      else return SizedBox();
                    },
                  ),
            ],),
          ],
        ),
      ),
    );
  }
}

class BodyText extends StatefulWidget {
  final Article article;
  const BodyText({
    super.key,
    required this.article
  });

  @override
  State<BodyText> createState() => _BodyTextState();
}

class _BodyTextState extends State<BodyText> {
  bool isLiked = false;
  @override
  void initState() {
    super.initState();
    isLiked = widget.article.isLike!;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(
              minHeight: 120
          ),
          child: Container(
            alignment: AlignmentDirectional.topStart,
            width: double.infinity,
            decoration: BoxDecoration(
                color: WHITE,
                border: Border.symmetric(horizontal: BorderSide(width: 1, color: GREY))
            ),
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.article.photos != null)
                  Column(
                    children: widget.article.photos!.map((photo) {
                      return Image.network(
                        photo.imgPath);
                    }).toList(),
                  ) else SizedBox(),
                  SizedBox(height: 10),
                  Text(widget.article.body, style: Theme.of(context).textTheme.bodyMedium,),
                ],
              ),
            ),
          ),
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
                  Text('댓글 ${widget.article.commentCount}', style: Theme.of(context).textTheme.labelMedium,),
                  SizedBox(width: 20),
                  Text('저장 ${widget.article.scrapCount}', style: Theme.of(context).textTheme.labelMedium,)
                ],
              ),
              IconButton(
                  onPressed: () async {
                    final res = await postLikeRequest(widget.article.id.toString());
                    if(res.data['code'] == 200){
                      setState(() {
                        isLiked = !isLiked;
                      });
                    }
                  },
                  icon: isLiked ? Icon(Icons.star_rate) : Icon(Icons.star_outline),
                  color: isLiked ? Colors.yellow : GREY2)
            ],
          ),
        ),
      ],
    );
  }
}

class BodyComments extends StatelessWidget {
  final List<Comment> comments;
  const BodyComments({super.key,required this.comments});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: WHITE,
            border: Border(top: BorderSide(width: 5, color: GREY))
          ),
          child: SizedBox(height: 5,width: double.infinity,),
        ),
        Column(
          children: comments.map((comment) {
            return CommentWidget(comment: comment);
          }).toList(),
        ),
      ],
    );
  }
}

class CommentWidget extends StatefulWidget {
  final Comment comment;
  const CommentWidget({super.key, required this.comment});

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  
  bool isEditMode = false;

  Widget _editButton(){
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final state = ref.read(UserProvider);
        if(state.id == widget.comment.ownerId)
          return _EditWidget(
            //본인이 생성한 댓글인지 구별하는 로직 필요
            buttonText1: '댓글 삭제', buttonText2: '댓글 수정',
            onPressedFn1: () async {
              //댓글 삭제
              bool confirmed = await confirmDialog(context);
              if (confirmed) {
                // 수락(Confirm) 버튼을 눌렀을 때의 로직
                DeleteComment.deleteComment(widget.comment.id.toString());
              } else {
                // 취소(Cancel) 버튼을 눌렀을 때의 로직
                return null;
              }
            },
            onPressedFn2: (){
              setState(() {
                isEditMode = true;
              });
              //댓글 수정
            },);
        else return SizedBox();
      },
    );
  }

  Widget _comment({required Comment comment, required context}){
    //댓글 생성 시간으로
    //몇분전, 몇시간전 으로 포맷해야함. 몇 분 전일시 new추가
    final formattedDate = formatDate(DateTime.now());

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: WHITE,
              border: Border(bottom: BorderSide(width: 1, color: GREY2))
          ),
          padding: const EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(widget.comment.nickname, style: Theme.of(context).textTheme.bodyLarge,),
                      SizedBox(width: 5,),
                      Text(formattedDate, style: Theme.of(context).textTheme.labelMedium,)
                    ],),
                  _editButton()
                ],
              ),
              Text(widget.comment.comment, style: Theme.of(context).textTheme.bodyMedium,)
            ],
          ),
        ),
      ],
    );
  }

  Widget _editingComment({required Comment comment}){
    final TextEditingController _controller = TextEditingController(text: comment.comment);
    // 댓글 업데이트 시간 추가해야함
    //몇분전, 몇시간전 으로 포맷해야함. 몇 분 전일시 new추가
    final formattedDate = formatDate(DateTime.now());
    return Consumer(builder: (BuildContext context, WidgetRef ref, widget){
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(comment.nickname, style: Theme.of(context).textTheme.bodyLarge,),
                        SizedBox(width: 5,),
                        Text(formattedDate, style: Theme.of(context).textTheme.labelMedium,)
                      ],),
                  ],
                ),
                SizedBox(height: 20),
                TextFormField(
                  controller: _controller,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(onPressed: (){
                      PatchComment.patchComment(commentId: comment.id.toString(), comment: _controller.text);
                      setState(() {
                        isEditMode = false;
                      });
                    }, child: Text('수정', style: Theme.of(context).textTheme.bodyMedium,)),
                    TextButton(onPressed: (){
                      setState(() {
                        isEditMode = false;
                      });
                    }, child: Text('취소',style: Theme.of(context).textTheme.bodyMedium),)
                  ],
                )
              ],
            ),
          ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    if(isEditMode == true)
      return _editingComment(comment: widget.comment);
    else  
      return _comment(comment: widget.comment, context: context);
    }
  }






