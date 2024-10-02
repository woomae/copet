import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet/api/walkmamp/getWalkMaps.dart';
import 'package:pet/common/component/widgets/spinner_widget.dart';
import 'package:pet/const/models/articles.dart';
import 'package:pet/pages/community/post_list.dart';
import 'package:pet/pages/profile/walkmap_list.dart';
import 'package:pet/providers/user_notifier_provider.dart';

import '../../api/article/getArticles.dart';
import '../../const/models/walkmap_mode.dart';
import '../../style/colors.dart';

class ProfileInformationContainer extends StatefulWidget {
  const ProfileInformationContainer({super.key});

  @override
  State<ProfileInformationContainer> createState() => _ProfileInformationContainerState();
}

class _ProfileInformationContainerState extends State<ProfileInformationContainer> {
  final List<String> profileCategory = ['산책', '게시글', '저장'];
  String currentState = '산책';
  Future<List<Article>>? currentFuture;

  @override
  void initState() {
    super.initState();
    // 초기 currentFuture 설정
    currentFuture = Future.value([]);
  }

  void updateFuture(int userId) {
    if (currentState == '게시글' ) {
      currentFuture = GetArticles.getOwnerArticles(userId: userId);
    }
    if(currentState == '저장'){
      currentFuture = GetArticles.getLikeArticles(userId: userId);
    }
    else {
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
                onPressed: () {
                  setState(() {
                    currentState = e;
                    updateFuture(userId);
                  });
                },
                buttonName: e,
                isPressed: currentState == e,
              )).toList()
          ),
        ),

        currentState == '게시글' || currentState == '저장' ?
        Flexible(
          child: FutureBuilder<List<Article>>(
            future: currentFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SpinnerWidget();
              }
              if (snapshot.hasError) {
                final err = snapshot.error;
                print('profileInformation error : $err');
                return Center(child: Text('error'));
              }
              if (snapshot.hasData) {
                if (currentState == '게시글' || currentState == '저장') {
                  return PostList(
                    length: snapshot.data!.length,
                    comments: snapshot.data!, // `comments`로 수정
                  );
                }
              }
                return SizedBox();
            },
          ),
        )
        :
        Flexible(
          child: FutureBuilder<List<WalkMap>>(
            future: getWalkMaps(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SpinnerWidget();
              }
              if (snapshot.hasError) {
                final err = snapshot.error;
                print('profileWalkmap error : $err');
                return Center(child: Text('error'));
              }
              if (snapshot.hasData) {
                  WalkmapList(walkMap: snapshot.data!,);
              }
              return SizedBox();
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
    required this.isPressed,
  });

  final VoidCallback onPressed;
  final String buttonName;
  final bool isPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        foregroundColor: isPressed ? BLACK : GREY3,
        splashFactory: NoSplash.splashFactory,
      ),
      onPressed: onPressed,
      child: Text(buttonName),
    );
  }
}
