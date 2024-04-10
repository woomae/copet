import 'package:flutter/material.dart';
import 'package:pet/common/component/appbars/go_back_appbar.dart';
import 'package:pet/pages/profile/profile_modify.dart';
import 'package:pet/style/colors.dart';

class SettingHome extends StatelessWidget {
  const SettingHome ({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GoBackAppBar(),
      body: const Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SettingButton(buttonName: '프로필 수정'),
          SettingButton(buttonName: '키워드 수정'),
          SettingButton(buttonName: '알림 설정'),
          SettingButton(buttonName: '계정 탈퇴'),
        ],
      )
    );
  }
}

class SettingButton extends StatelessWidget {
  const SettingButton({
    super.key,
    required this.buttonName
  });

  final String buttonName;
  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 0.5, color: Colors.black)
        )
      ),
      width: double.infinity,
      child: TextButton(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero
              ),
              foregroundColor: Colors.grey,
              ),
              onPressed: (){
              if(buttonName == '프로필 수정'){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfileModify()));
              }
              },
              child: Row(
                children: [
                  Text(buttonName, style: const TextStyle(color: Colors.black),),
                  const Spacer(),
                  const Icon(Icons.arrow_forward_ios, color: Colors.black, size: 20,)
                ],
              ))
    );
  }
}
