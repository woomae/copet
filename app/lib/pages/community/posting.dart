import 'package:flutter/material.dart';

import '../../style/icons.dart';


// 추후 수정 예정.

class Posting extends StatelessWidget {
  const Posting({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Scaffold(
        appBar: _AppBar(),
        body: Column(
          children: [
            Flexible(
              flex: 9,
              child: _Body()
            ),
            Flexible(flex: 1,
              child: _BottomAppBar(),)
          ],
        ),
      ),
    );
  }
}

PreferredSizeWidget _AppBar(){
  return AppBar(
    centerTitle: true,
    leading: IconButton( //onpressd가 null일때 자동으로 회색으로 변경됨
      color: Colors.black,
      icon: GO_BACK_ICON,
      iconSize: 20,
      onPressed: (){

      },
    ),
    title: const Text('글쓰기',
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.normal,
        )),
    shape: const Border(
        bottom: BorderSide(color: Colors.grey ,width: 0.5)
    ),
  );
}

Widget _Body(){
  return Padding(
    padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5
    ),
    child: Column(
      children: [
        TextFormField(
          decoration: const InputDecoration(
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white24)
              ),
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white24)
              ),
              labelText: "제목",
              labelStyle: TextStyle(color: Colors.grey)
          ),
        ),
        TextFormField(
          decoration: const InputDecoration(
              hintText: "글을 작성해주세요",
              labelStyle: TextStyle(color: Colors.grey),
              border: UnderlineInputBorder(
                  borderSide: BorderSide.none
              )
          ),
          keyboardType: TextInputType.multiline,
          maxLines: null,
        ),
      ],
    ),
  );
}

Widget _BottomAppBar(){
  return Container(
    height: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 10),
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

          }, icon: const Icon(Icons.file_present_rounded),),
        const Spacer(),
        ElevatedButton(
            onPressed: (){

            }, child: const Text("게시")),
      ],
    ),
  );
}