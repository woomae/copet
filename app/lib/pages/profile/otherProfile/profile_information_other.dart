import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet/const/models/articles.dart';
import 'package:pet/pages/community/post_list.dart';
import 'package:pet/providers/user_notifier_provider.dart';

import '../../../api/article/getArticles.dart';
import '../../../const/models/comments_model.dart';
import '../../../style/colors.dart';

class ProfileInformationother extends StatefulWidget {
  ProfileInformationother({
    super.key,});

  @override
  State<ProfileInformationother> createState() => _ProfileInformationotherState();
}

class _ProfileInformationotherState extends State<ProfileInformationother> {
  final List<String> profileCategory = ['산책', '게시글'];
  String currentState = '산책';
  Future<List<Article>>? currentFuture;

  @override
  void initState() {
    super.initState();
    // 초기 currentFuture 설정
    currentFuture = Future.value([]);
  }

  void updateFuture(int userId) {
    if (currentState == '게시글') {
      currentFuture = GetArticles.getOwnerArticles(userId: userId);
    } else {
      currentFuture = Future.value([]);
    }
  }

  @override
  Widget build(BuildContext context) {
    final userId = ProviderScope.containerOf(context).read(UserProvider).id;

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
                      updateFuture(userId);
                    });
                  }, buttonName: e, isPressed : currentState == e)).toList()
          ),
        ),
        Flexible(
          child: FutureBuilder<List<Article>>(
            future: currentFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: Text('loading'));
              }
              if (snapshot.hasError) {
                final err = snapshot.error;
                print('profileInformation error : $err');
                return Center(child: Text('error'));
              }
              if (snapshot.hasData) {
                if (currentState == '게시글') {
                  return PostList(
                    length: snapshot.data!.length,
                    comments: snapshot.data!, // `comments`로 수정
                  );
                }
              }
              return Center(child: Text('No Data'));
            },
          ),
        ),
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