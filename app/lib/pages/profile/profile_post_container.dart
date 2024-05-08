import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../style/colors.dart';

class MyPost extends StatelessWidget {
  const MyPost({
    super.key,});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            _smallCategory('산책'),
            _smallCategory('게시글'),
            _smallCategory('저장')
          ],),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(0),
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              //썸네일, 작성자, 제목, 작성일, /스크랩 여부..?,좋아요 여부,,?,
              return ;
            },),
        )
      ],
    );
  }
}
Widget _smallCategory(String text){
  return Expanded(
    child: GestureDetector(
      onTap: (){
        print(text);
      },
      child: Container(
        padding: EdgeInsets.all(10),
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: WHITE,
              border: Border(bottom: BorderSide(width: 1, color: GREY_BORDER),)
          ),
          child: Text(text)
      ),
    ),
  );
}