import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet/pages/profile/profile_keyword.dart';
import 'package:pet/providers/user_data_notifier_provider.dart';
import '../../../login/login_area.dart';
import '../../../style/icons.dart';

PreferredSizeWidget ModifyAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    leading: Back(),
    shape: const Border(
      bottom: BorderSide(color: Colors.grey, width: 0.5),
    ),
    centerTitle: false,
    actions: [
      Consumer(
        builder: (context, ref, child) {
          final selectedState = ref.watch(stateProvider);
          final selectedCity = ref.watch(cityProvider);
          final selectedDistrict = ref.watch(districtProvider);

          return TextButton(
            onPressed: () {
              // 정보 업데이트
              ref.read(userDataProvider.notifier).updateUserData(
                state_: selectedState != '지역선택' ? selectedState : null,
                city: selectedCity != '지역선택' ? selectedCity : null,
                district: selectedDistrict != '지역선택' ? selectedDistrict : null,
              );

              // 페이지 이동
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => profile_keyword()),
              );
            },
            child: Text(
              '다음',
              style: TextStyle(
                fontFamily: 'NotoSansKR',
                fontWeight: FontWeight.w400,
                color: Color(0xFF222222),
                fontSize: 20,
              ),
            ),
          );
        },
      ),
    ],
  );
}

class Back extends StatelessWidget {
  Back({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: GO_BACK_ICON,
    );
  }
}
