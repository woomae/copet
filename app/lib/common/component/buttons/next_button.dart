import 'package:flutter/material.dart';

import '../../../style/colors.dart';

class Nextbutton extends StatelessWidget {
  final Function onPressed;
  final bool enabled; // 입력 여부에 따른 버튼 활성화 여부

  const Nextbutton({
    super.key,
    required this.onPressed,
    this.enabled = true, // 기본값은 true로 설정
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ElevatedButton(
        onPressed: enabled ? () => onPressed() : null, // 입력이 있을 때만 onPressed 호출
        style: ElevatedButton.styleFrom(
          foregroundColor: WHITE,
          backgroundColor: enabled ? PRIMARY_COLOR : Colors.grey,
          textStyle: TextStyle(color: WHITE),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          minimumSize: Size(100, 50),
        ),
        child: Text(
          '다음',
        ),
      ),
    );
  }
}
