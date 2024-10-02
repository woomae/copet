import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../api/follow/getFollow.dart';
import '../../../api/follow/getFollower.dart';
import '../../../common/component/appbars/go_back_appbar.dart';
import '../../../common/component/widgets/spinner_widget.dart';
import '../../../const/models/friends_model.dart';
import '../../../style/colors.dart';
import 'follow.dart';

class FollowerList extends StatelessWidget {
  const FollowerList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GoBackAppBar(),
      backgroundColor: WHITE,
      body: FutureBuilder<Friends>(
        future: getFollower(),
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.waiting)
            return SpinnerWidget();
          if (snapshot.hasError) {
            return Center(child: Text('error'));
          }
          if (snapshot.hasData) {
            return FriendsList(friends: snapshot.data!);
          }
          else
            return SizedBox();
        },
      ),
    );;
  }
}
