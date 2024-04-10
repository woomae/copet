import 'package:flutter/material.dart';
import 'package:pet/common/component/appbars/post_appbar.dart';
import 'package:pet/const/category_list.dart';

import '../../style/colors.dart';


// 추후 수정 예정.
class PostingPage extends StatelessWidget {
  const PostingPage({super.key});

  @override
  Widget build(BuildContext context) {

    void postPostingData(){
      print('asdf');
    }
    return Scaffold(
        appBar: PostAppBar(postPostingData),
        body: Column(
          children: [
            Expanded(child: _Body()),
            _BottomAppBar()
          ],
        ),
    );
  }
}


class _Body extends StatelessWidget {
  static const _hintText = """
본문 내용을 적어주세요.
사진은 최대 5장까지 업로드 가능합니다.

남을 비방하거나 욕설 등의 부적절한 글은 삼가주세요.""";
  const _Body({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(padding: EdgeInsets.only(bottom: 10)),
            TextFormField(
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
              ),
            ),

            const Padding(padding: EdgeInsets.only(bottom: 10)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Padding(padding: EdgeInsets.only(bottom: 10)),
                TextFormField(
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
                  minLines: 10,
                  maxLines: null,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomAppBar extends StatefulWidget {
  _BottomAppBar({
    super.key,
  });
  @override
  State<_BottomAppBar> createState() => _BottomAppBarState();
}

class _BottomAppBarState extends State<_BottomAppBar> {
  late String currentCategory = '';


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
            onPressed: (){

            }, icon: const Icon(Icons.camera_alt),color: PRIMARY_COLOR,),
          Spacer(),
          Row(
            children: categoryList.map((e) => GestureDetector(
              onTap: (){
                setState(() {
                  currentCategory = e.toString();
                  print(currentCategory);
                });
              },
              child: PostCategoryButton(
                  currentCategory: currentCategory,
                  categoryName: e,),
            )
            ).toList(),
          )
        ],
      ),
    );
  }
}

class PostCategoryButton extends StatelessWidget {
  final String categoryName;
  final String currentCategory;
  const PostCategoryButton({
    super.key,
    required this.categoryName,
    required this.currentCategory
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3),
      child: Container(
        alignment: Alignment.center,
        constraints: BoxConstraints(minWidth: 70),
        decoration: BoxDecoration(
          color: currentCategory == categoryName ? PRIMARY_COLOR : null,
          border: Border.all(width: 1, color: PRIMARY_COLOR),
          borderRadius: BorderRadius.circular(20)
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Text(categoryName, style: TextStyle(
            fontWeight: FontWeight.w600,
            color: currentCategory == categoryName ? WHITE : PRIMARY_COLOR,
            fontSize: Theme.of(context).textTheme.bodyMedium?.fontSize
          ),),
        ),
      ),
    );
  }
}
