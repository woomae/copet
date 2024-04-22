import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet/api/postPosting.dart';
import 'package:pet/common/component/appbars/post_appbar.dart';
import 'package:pet/const/category_list.dart';
import 'package:pet/providers/posting_notifier_provider.dart';
import '../../style/colors.dart';


// 추후 수정 예정.
class PostingPage extends ConsumerWidget {

  const PostingPage({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //postProvider 초기화
    ref.invalidate(PostingProvider);

    void postPostingData() async{
      final state = ref.watch(PostingProvider);
      Navigator.pop(context);
      ref.watch(PostingProvider.notifier).updatePosting(
        //userId 고정
          owner_id: 1
      );
        await PostPosting.postPosting(
            owner_id: 1,
            title: state.title ,
            body: state.body,
            category: state.category);
    }

    return Scaffold(
        appBar: PostAppBar( postPostingData ),
        body: GestureDetector(
          onDoubleTap: (){
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Container(
            color: WHITE,
            child: Column(
              children: [
                Expanded(
                    child: _Body()),
                _BottomAppBar()
              ],
            ),
          ),
        ),
      resizeToAvoidBottomInset: false,
    );
  }
}


class _Body extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20
        ),
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
                Padding(padding: EdgeInsets.only(bottom: 10)),
                BodyInput()
              ],
            ),
          ],
        ),
      ),
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





class _BottomAppBar extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.only(
          right: 10,
          left: 10,
          // 하단 탭바 높이만큼 더 올라가더라,, 그거 빼줘야함
          bottom:MediaQuery.of(context).viewInsets.bottom + 10 ,
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
              final XFile? image = await picker.pickImage(source: ImageSource.gallery);
            }, icon: const Icon(Icons.camera_alt),color: PRIMARY_COLOR,),
          const Spacer(),
          Row(
            children: categoryList.map(
                    (e) => PostCategoryButton(categoryName: e,)).toList(),
          )
        ],
      ),
    );
  }
}

class PostCategoryButton extends ConsumerWidget {
  final String categoryName;
  const PostCategoryButton({
    super.key,
    required this.categoryName,
  });


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final categoryState = ref.watch(PostingProvider).category;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: Container(

        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: categoryName == categoryState ? PRIMARY_COLOR : null,
          border: Border.all(width: 1, color: PRIMARY_COLOR),
          borderRadius: BorderRadius.circular(20)
        ),
        child: TextButton(
          onPressed: (){
            ref.read(PostingProvider.notifier).updatePosting(category: categoryName);
          },
          child: Text(
            categoryName, style: TextStyle(
            fontWeight: FontWeight.w600,
            color: categoryName == categoryState ? WHITE : PRIMARY_COLOR,
            fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize
          ),),
        ),
      ),
    );
  }
}
