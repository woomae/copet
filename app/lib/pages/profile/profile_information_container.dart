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
  Future<List<Comments>>? currentFuture;

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userId = ProviderScope.containerOf(context).read(UserProvider).id.toString();
    final Function setCurrentState = (String state){
        currentState = state;
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
                    setState(() {
                      setCurrentState(e);
                    });
                  }, buttonName: e, isPressed : currentState == e)).toList()
          ),
        ),
        Flexible(
          child: FutureBuilder(
            future:  currentFuture,
            builder: (context, snapshot){
              if(snapshot.data != null){
                if(currentState == '산책'){
                  currentFuture = null;
                }
                if(currentState == '게시글'){
                  currentFuture = GetArticles.getOwnerArticles(userId: userId);
                  return PostList(length: snapshot.data!.length, comments: snapshot.data!);
                }
                if(currentState == '저장'){
                  currentFuture = null;
                }

              }
              if(snapshot.connectionState == ConnectionState.waiting){
                return Center(child: Text('loading'));
              }
              if(snapshot.hasError){
                final err = snapshot.error;
                print('profileInformation error : $err');
                return Center(child: Text('error'));
              }
              else{
                return Center(child: Text('No Data'));
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
