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
        body: const Column(
          children: [
            Expanded(child: _Body()),
            _BottomAppBar()
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
    shape: const Border(
        bottom: BorderSide(color: Colors.grey ,width: 0.5)
    ),
  );
}

class CategoryDropDown extends StatefulWidget {
  const CategoryDropDown({super.key});

  @override
  State<CategoryDropDown> createState() => _CategoryDropDownState();
}

class _CategoryDropDownState extends State<CategoryDropDown> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}


class _Body extends StatelessWidget {
  const _Body({super.key});


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 15
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('제목', style: Theme.of(context).textTheme.bodyMedium,),
            const Padding(padding: EdgeInsets.only(bottom: 10)),
            TextFormField(
              style : Theme.of(context).textTheme.bodyMedium,
              decoration: const InputDecoration(
                enabledBorder:  OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.grey)
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.grey)
                ),
                border: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.grey)
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 10)),
            const Text('카테고리'),
            const Padding(padding: EdgeInsets.only(bottom: 10)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text('본문',style: Theme.of(context).textTheme.bodyMedium,),
                const Padding(padding: EdgeInsets.only(bottom: 10)),
                TextFormField(
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: const InputDecoration(
                    enabledBorder:  OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.grey)
                    ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.grey)
                      ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 1, color: Colors.grey)
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

class _BottomAppBar extends StatelessWidget {
  const _BottomAppBar({super.key});

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

            }, icon: const Icon(Icons.file_present_rounded),),
          const Spacer(),
          ElevatedButton(
              onPressed: (){

              }, child: const Text("게시")),
        ],
      ),
    );
  }
}
