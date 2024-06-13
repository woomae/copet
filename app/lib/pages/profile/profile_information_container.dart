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
    super.key,
    this.othersId
  });
  final int? othersId;

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
    final userId = widget.othersId != null ? widget.othersId
        : ProviderScope.containerOf(context).read(UserProvider).id;
    if(widget.othersId != null){
      profileCategory.removeLast();
    }
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
                      currentState = e;
                      if(currentState == profileCategory[0]){
                        currentFuture = null;
                      }
                      if(currentState == profileCategory[1]){
                        currentFuture = GetArticles.getOwnerArticles(userId: userId.toString());
                      }
                      if(currentState == profileCategory[2] ){
                        currentFuture = GetArticles.getLikeArticles(userId: userId!);
                      }
                    });
                  }, buttonName: e, isPressed : currentState == e)).toList()
          ),
        ),
        Flexible(
          child: FutureBuilder(
            future:  currentFuture,
            builder: (context, snapshot){
              if(snapshot.data != null){
                print('snapshotData : $snapshot');
                if(currentFuture == null){
                  return Center(child: Text('currentFuture null'));
                }
                return PostList(length: snapshot.data!.length, comments: snapshot.data!);
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
