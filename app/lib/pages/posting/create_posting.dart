import 'dart:ffi';
import 'package:flutter/material.dart';


// 추후 수정 예정.
void main() {
  runApp(const Creating_Post());
}

class Creating_Post extends StatelessWidget {
  const Creating_Post({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: const IconButton( //onpressd가 null일때 자동으로 회쌕으로 변경됨
            color: Colors.black,
            icon: Icon(Icons.arrow_back_ios_new),
            iconSize: 20,
            onPressed: null,
          ),
          title: const Text('글쓰기',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.normal,
            )),
          shape: const Border(
            bottom: BorderSide(color: Colors.grey ,width: 0.5)
          ),
        ),
        body: Column(
          children: [
            Flexible(
              flex: 9,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)
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
      ),),
            Flexible(flex: 1,child: Container(
              margin: EdgeInsets.only(bottom: 0),
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.grey,
                    width: 0.5
                  )
                )
              ),
              width: double.infinity,
              height: double.infinity,
              child: const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: IconButton(
                      onPressed: null, icon: Icon(Icons.file_present_rounded),),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: TextButton(onPressed: null, child: Text("data")),
                  )
                ],
              ),
            ),)
          ],
        ),
      ),
    );
  }
}