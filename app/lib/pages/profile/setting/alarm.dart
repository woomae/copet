import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet/style/colors.dart';

import '../../../common/component/appbars/go_back_appbar.dart';

class alarm extends StatefulWidget {
  const alarm({super.key});

  @override
  State<alarm> createState() => _alarmState();
}

class _alarmState extends State<alarm> {
  bool _isNotificationEnabled = true; // 알림 설정 상태 변수

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: GoBackAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 40, top: 10, right: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '알림 설정',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Segoe',
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF222222),
                  ),
                ),
                CupertinoSwitch(
                  value: _isNotificationEnabled,
                  onChanged: (bool value) {
                    setState(() {
                      _isNotificationEnabled = value; // 스위치 상태 변경
                      // 여기에 알림 설정을 처리하는 로직을 추가할 수 있음
                    });
                  },
                  activeColor: PRIMARY_COLOR, // 액티브(활성) 상태의 색상
                  //inactiveTrackColor: Color(0xFFEEEEEE), // 인액티브(비활성) 상태의 트랙 색상
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}




