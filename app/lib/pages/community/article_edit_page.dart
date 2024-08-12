import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet/api/article/putArticle.dart';
import 'package:pet/common/component/appbars/post_appbar.dart';
import 'package:pet/pages/community/posting_page.dart';

import '../../common/component/dialogs/commonDialog.dart';
import '../../providers/posting_notifier_provider.dart';
import '../../style/colors.dart';

class ArticleEditPage extends ConsumerWidget {
  final String articleId;
  const ArticleEditPage({super.key, required this.articleId});

  void putArticleData(BuildContext context, WidgetRef ref, String articleId,List<String>? prePhotos) async{
    void showCommonDialog({required String content, required BuildContext context}){
      showDialog(context: context, builder: (context){
        return CommonDialog(content: content);
      });
    }
    final state = ref.watch(PostingProvider);
    if(state.title == ''){
      showCommonDialog(content: '제목을 입력해주세요', context: context);
    }
    if(state.title != '' && state.body == ''){
      showCommonDialog(content:'내용을 입력해주세요', context: context);
    }
    if(state.title != '' && state.body != '' && state.category == ''){
      showCommonDialog(content: '카테고리를 선택해주세요', context: context);
    }
    if(state.category != '' && state.title != '' && state.body != '' ){
      print(state.title);
      print(state.body);
      print(state.category);
      print(state.images);
      print('prePhotos : $prePhotos');
      try{
          await PutArticle.putArticle(
              articleId: articleId,
              title: state.title,
              body: state.body,
              category: state.category,
              prePhotos: prePhotos,
              nextPhotos: state.images
          );
      }
      catch(err){
        //오류처리
        print(err);
      }
      ref.invalidate(PostingProvider);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<String>? prePhotos = ref.read(PostingProvider).images?.map((e)=> e.imgPath).toList();
    print(prePhotos);
    return Scaffold(
      appBar: PostAppBar( ()=> putArticleData(context, ref, articleId, prePhotos) ),
      //뒤로가기 감지 시 상태 초기화
      body: PopScope(
        onPopInvoked: (bool didPop){
          ref.invalidate(PostingProvider);
        },
        child: GestureDetector(
          onDoubleTap: (){
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Container(
            color: WHITE,
            child: PostingBody(),
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
