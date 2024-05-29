import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet/api/getArticles.dart';
import 'package:pet/const/models/articles.dart';
import 'package:pet/pages/community/post_list.dart';
import 'package:pet/providers/user_notifier_provider.dart';

import '../../style/colors.dart';

class ProfileInformationContainer extends StatefulWidget {
  ProfileInformationContainer({
    super.key,});

  @override
  State<ProfileInformationContainer> createState() => _ProfileInformationContainerState();
}

class _ProfileInformationContainerState extends State<ProfileInformationContainer> {
  final List<String> profileCategory = ['산책', '게시글', '저장'];
  String currentState = '산책';

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userId = ProviderScope.containerOf(context).read(UserProvider).id;
    final setCurrentState = (String state){
      setState(() {
        currentState = state;
      });
    };
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: WHITE,
            border: Border(bottom: BorderSide(width: 1, color: GREY3))
            ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: profileCategory.map((e) => _categoryButton(
                  onPressed: (){
                    setCurrentState(e);
                    print(currentState);
                  }, buttonName: e, isPressed : currentState == e)).toList()
          ),
        ),
        Flexible(
          child: FutureBuilder(
            future:  GetArticles.getArticles(),
            builder: (context, snapshot){
              final List<Comments>? comments = snapshot.data;
              if(comments != null){
                if(currentState == profileCategory[0]){
                  //산책
                  return SizedBox();
                }
                if(currentState == profileCategory[1]){
                  //게시글
                  final List<Comments> userComments = comments.where((element) => element.iId == userId).toList();
                  return PostList(length: userComments.length, comments: userComments);
                }
                if(currentState == profileCategory[2]){
                  //저장
                  return SizedBox();
                }
              }
              if(snapshot.connectionState == ConnectionState.waiting){
                return Center(child: Text('loading'));
              }
              else{
                final err = snapshot.error;
                print(comments);
                print('profileInformation error : $err');
                return Center(child: Text('error'));
              }
            },
          ),
        )
      ],
    );
  }
}
class _categoryButton extends StatelessWidget {
  const _categoryButton({
    super.key,
    required this.onPressed,
    required this.buttonName,
    required this.isPressed
  });
  final VoidCallback onPressed;
  final String buttonName;
  final bool isPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
          foregroundColor: isPressed ? BLACK : GREY3,
          splashFactory: NoSplash.splashFactory
        ),
        onPressed: onPressed,
        child: Text(buttonName));
  }
}
