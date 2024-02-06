import 'package:flutter/material.dart';
import 'package:pet/common/component/go_back_appbar.dart';

class SettingHome extends StatelessWidget {
  const SettingHome ({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: goBackAppBar(),
      body: Text('설정 페이지'),
    );
  }
}
