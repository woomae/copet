import 'package:flutter/material.dart';
import 'package:pet/api/getUser.dart';
import 'package:pet/const/models/users_model.dart';
import 'package:pet/pages/profile/profile_container.dart';
import 'package:pet/pages/profile/profile_main.dart';

class OthersProfile extends StatelessWidget {
  const OthersProfile({
    super.key,
    required this.othersId
  });
  final int othersId;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ProfileBody(
          profileContainer: _profileContainer(othersId: othersId,),
          profileInformationContainer: _profileInformationContainer()
          ),
      ),
    );
  }
}
class _profileContainer extends StatelessWidget {
  const _profileContainer({
    super.key,
    required this.othersId
  });
  final int othersId;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UsersModel>(
        future: GetUser.getUser(othersId.toString()),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return SizedBox();
          }
          if(snapshot.hasData){
            return ProfileContainer(otherState: snapshot.data);
          }
          if(snapshot.hasError){
            return Center(child: Text('error'),);
          }
          else{
            return SizedBox();
          }
        });
  }
}
class _profileInformationContainer extends StatelessWidget {
  const _profileInformationContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
