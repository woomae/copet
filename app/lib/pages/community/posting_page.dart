import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet/common/component/appbars/post_appbar.dart';
import 'package:pet/common/component/dialogs/commonDialog.dart';
import 'package:pet/const/category_list.dart';
import 'package:pet/providers/posting_notifier_provider.dart';
import '../../api/postPosting.dart';
import '../../style/colors.dart';


// 추후 수정 예정.
class PostingPage extends ConsumerWidget {

  const PostingPage({super.key});

  void showCommonDialog({required String content, required BuildContext context}){
    showDialog(context: context, builder: (context){
      return CommonDialog(content: content);
    });
  }

  void postPostingData(BuildContext context, WidgetRef ref) async{
    final state = ref.watch(PostingProvider);
    ref.read(PostingProvider.notifier).updatePosting(
      //userId 고정
        owner_id: 1
    );
    print('--------------------------------------');
    print(state.title);

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
      print('------------------------------------------------------------송신');
      print(state.title);
      print(state.body);
      print(state.category);
      try{
        await PostPosting.postPosting(
            owner_id: 1,
            title: state.title ?? '제목없음',
            body: state.body,
            category: state.category,
            imagePaths: null ?? state.imagePaths
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
    ref.invalidate(PostingProvider);
    //postProvider 초기화

    return Scaffold(
        appBar: PostAppBar( ()=> postPostingData(context, ref) ),
        body: GestureDetector(
          onDoubleTap: (){
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Container(
            color: WHITE,
            child: _Body(),
          ),
        ),
      resizeToAvoidBottomInset: false,
    );
  }
}


class _Body extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(PostingProvider);
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.only(bottom: 10)),
                  TitleInput(),
                
                  Padding(padding: EdgeInsets.only(bottom: 10)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: state.imagePaths != null ?
                        Column(
                            children: state.imagePaths!.map(
                                    (e) => Image.file(File(e), width: 300, height: 300, fit: BoxFit.cover,)).toList()
                        ) : null,
                      ),
                      BodyInput()
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        _BottomAppBar()
      ],
    );
  }
}
class TitleInput extends ConsumerWidget {
  const TitleInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return TextFormField(
      onChanged: (e){
        ref.read(PostingProvider.notifier).updatePosting(title: e);
      },
      textInputAction: TextInputAction.next,
      style : Theme.of(context).textTheme.bodyLarge,
      decoration: const InputDecoration(
        hintText: '제목',
        hintStyle: TextStyle(
            fontSize: 20,
            color: GREY1
        ),
        enabledBorder:  UnderlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.grey)
        ),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.grey)
        ),
        border: UnderlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.grey)
        ),
      )
    );
  }
}

class BodyInput extends ConsumerWidget {
  const BodyInput({super.key});
  static const _hintText = """
본문 내용을 적어주세요.
사진은 최대 5장까지 업로드 가능합니다.

남을 비방하거나 욕설 등의 부적절한 글은 삼가주세요.""";

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return TextFormField(
      onChanged: (e){
        ref.read(PostingProvider.notifier).updatePosting(body: e);
      },
      style: Theme.of(context).textTheme.bodyMedium,
      decoration: const InputDecoration(
          hintText: _hintText,
          enabledBorder:  UnderlineInputBorder(
              borderSide: BorderSide(width: 0, color: Colors.white)
          ),
          border: UnderlineInputBorder(
              borderSide: BorderSide(width: 0, color: Colors.white)
          ),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(width: 0, color: Colors.white)
          )
      ),
      keyboardType: TextInputType.multiline,
      minLines: 20,
      maxLines: null,
    );
  }
}





class _BottomAppBar extends ConsumerWidget {

  final heightProvider = StateProvider<bool>((ref) => false);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(heightProvider);
    return Container(
      padding: EdgeInsets.only(
          right: 10,
          left: 10,
          // 하단 탭바 높이만큼 더 올라가더라,, 그거 빼줘야함
          bottom: MediaQuery.of(context).viewInsets.bottom > 0 ? MediaQuery.of(context).viewInsets.bottom - 50 : 10,
          top: 10 ),
      decoration: const BoxDecoration(
          border: Border(
              top: BorderSide(
                  color: Colors.grey,
                  width: 0.5
              )
          )
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: ()async{
              var picker = ImagePicker();
              final List<XFile>? images = await picker.pickMultiImage();
              if(images != null) {
                final imagePaths = images.map((e) => e.path).toList();
                ref.read(PostingProvider.notifier).updatePosting(
                    images: imagePaths);
              }
            }, icon: const Icon(Icons.camera_alt),color: PRIMARY_COLOR,),
          const Spacer(),
          PostCategoryWidget(),

        ],
      ),
    );
  }
}

class PostCategoryWidget extends ConsumerWidget {
  const PostCategoryWidget({super.key,});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(PostingProvider);
    return Row(
        children:
        categoryList.map((categoryName) =>

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
              child: Container(
                padding: EdgeInsets.zero,
                decoration: BoxDecoration(
                  color: state.category == categoryName ? PRIMARY_COLOR : WHITE,
                  border: Border.all(width: 1, color: PRIMARY_COLOR),
                  borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    foregroundColor: PRIMARY_COLOR,
                  ),
                    onPressed: () {
                      ref.watch(PostingProvider.notifier).updatePosting(category: categoryName);
                      print(state.category);
                    },
                    child: Text(categoryName,
                        style: TextStyle(
                          color: state.category == categoryName ? WHITE : PRIMARY_COLOR,
                          fontWeight: FontWeight.w700,
                        ))),
              ),
            )
        ).toList()
    );
  }
}
