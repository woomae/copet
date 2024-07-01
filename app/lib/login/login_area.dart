import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet/common/component/buttons/dropdown_button.dart';
import 'package:pet/const/models/user_data_model.dart';
import 'package:pet/const/regions/jellanamdo/jeollanamdo.dart';
import 'package:pet/const/regions/region_list.dart';
import 'package:pet/login/login_agree.dart';
import 'package:pet/login/login_end.dart';
import 'package:pet/providers/user_data_notifier_provider.dart';
import 'package:pet/style/colors.dart';

import '../api/patchUserData.dart';
import '../common/component/buttons/next_button.dart';
import '../common/component/buttons/pre_button.dart';
import '../const/models/region_model.dart';
import '../providers/user_notifier_provider.dart';

const List<String> list1 = <String>['지역선택', 'Twwwwo', 'Three', 'Four'];
const List<String> list2 = <String>['지역선택', '1', '2', '3'];
const List<String> list3 = <String>['지역선택', '4', '5', '6'];

class loginarea extends ConsumerWidget {
  loginarea({super.key});
  //district 수정 필요

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userDataState = ref.watch(userDataProvider);
    //지역 상수에서 지역 이름만 가져와서 리스트화
    final List<String> regionsName = regionList.map((e) => e.stateName).toList();
    final List<String>? citiesName = City.getCityListByString(userDataState.region?.state);
    final List<String>? districtsName = District.getDistrictListByString(userDataState.region?.city);

    ref.listen(userDataProvider.select((userData) => userData.region?.state), (previous, next) {
      ref.read(userDataProvider.notifier).updateUserData( state_: next,city: null, district: null);
    });
    ref.listen(userDataProvider.select((userData) => userData.region?.city), (previous, next) {
      ref.read(userDataProvider.notifier).updateUserData(state_: userDataState.region?.state, city: next, district: null);
    });
    ref.listen(userDataProvider.select((userData) => userData.region?.district), (previous, next) {
      ref.read(userDataProvider.notifier).updateUserData(
          state_: userDataState.region?.state, city: userDataState.region?.city, district: next);
    });
    //지역 상수에서 각 단위의 이름만 추출해서 배열화
    //이미 읍면동이 선택된 상태에서 시를 선택했을 때, 이전의  읍면동과 시가 다르면 초기화.....


    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        //titleSpacing: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          '회원가입',
          style: TextStyle(
            fontFamily: 'Poetsen',
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'COPET',
                style: TextStyle(
                  fontFamily: 'Poetsen',
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
        shape: Border(
          bottom: BorderSide(color: Color(0xFFDEDEDE), width: 1.0),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 90, bottom: 40),
        child: Column(
          children: [
            Column(
              children: [
                _Title(),
                const SizedBox(height: 10.0),
                DropDownButton(
                  dropDownList: regionsName,
                  currentItem: userDataState.region?.state,
                  onPressed: (String e){
                    ref.read(userDataProvider.notifier).updateUserData(state_: e);
                },),
                const SizedBox(height: 10.0),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    DropDownButton(
                      dropDownList: citiesName,
                      currentItem: userDataState.region?.city,
                      onPressed: (String e){
                        ref.read(userDataProvider.notifier).updateUserData(city: e);                      }
                    ),
                    const SizedBox(width: 10.0),
                    DropDownButton(
                      dropDownList: districtsName,
                      currentItem: userDataState.region?.district,
                      onPressed: (String e){
                        print(districtsName);
                          ref.read(userDataProvider.notifier).updateUserData(district: e);
                    },),
                  ],
                ),

              ],
            ),
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  agreetext(),
                  const SizedBox(width: 70),
                  const SizedBox(width: 70),
                ],
              ),
              const SizedBox(height: 10),

        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      '지역 설정',
      style: TextStyle(
        fontSize: 20,
        color: Colors.black,
      ),
    );
  }
}

class DropdownButtonExample1 extends StatefulWidget {
  const DropdownButtonExample1({super.key});

  @override
  State<DropdownButtonExample1> createState() => _DropdownButtonExample1State();
}

class _DropdownButtonExample1State extends State<DropdownButtonExample1> {
  String dropdownValue = list1.first;

  //double menuWidth = 200.0; // 초기 값 설정, 원하는 값으로 조절

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), // 열릴 때의 모서리 둥글게 조절
      ),
      elevation: 0,
      onSelected: (String value) {
        setState(() {
          dropdownValue = value;
        });
      },
      itemBuilder: (BuildContext context) {
        return list1.map((String value) {
          // 각 항목의 너비를 측정
          //double itemWidth = getTextWidth(value, Theme.of(context).textTheme.bodyText2!);

          // 가장 긴 항목의 너비로 메뉴의 너비 설정
          //menuWidth = math.max(menuWidth, itemWidth);
          return PopupMenuItem<String>(
            value: value,
            child: Container(
              //width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), // 각 아이템의 모서리 둥글게 조절
              ),
              child: Text(value),
            ),
          );
        }).toList();
      },
      child: Container(
        //width: menuWidth, // 버튼과 메뉴의 너비를 동일하게 설정
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // 아이콘을 오른쪽 끝으로 이동
          children: [
            Text(
              dropdownValue,
              style: const TextStyle(color: Colors.black),
            ),
            Icon(Icons.arrow_drop_down, size: 40, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

class DropdownButtonExample2 extends StatefulWidget {
  const DropdownButtonExample2({super.key});

  @override
  State<DropdownButtonExample2> createState() => _DropdownButtonExample2State();
}

class _DropdownButtonExample2State extends State<DropdownButtonExample2> {
  String dropdownValue = list2.first;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), // 열릴 때의 모서리 둥글게 조절
      ),
      onSelected: (String value) {
        setState(() {
          dropdownValue = value;
        });
      },
      itemBuilder: (BuildContext context) {
        return list2.map((String value) {
          return PopupMenuItem<String>(
            value: value,
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), // 각 아이템의 모서리 둥글게 조절
              ),
              child: Text(value),
            ),
          );
        }).toList();
      },
      child: Container(
        //padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                dropdownValue,
                style: const TextStyle(color: Colors.black),
              ),
            ),
            const Icon(Icons.arrow_drop_down, size: 40, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

class DropdownButtonExample3 extends StatefulWidget {
  const DropdownButtonExample3({super.key});

  @override
  State<DropdownButtonExample3> createState() => _DropdownButtonExample3State();
}

class _DropdownButtonExample3State extends State<DropdownButtonExample3> {
  String dropdownValue = list3.first;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), // 열릴 때의 모서리 둥글게 조절
      ),
      onSelected: (String value) {
        setState(() {
          dropdownValue = value;
        });
      },
      itemBuilder: (BuildContext context) {
        return list3.map((String value) {
          return PopupMenuItem<String>(
            value: value,
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), // 각 아이템의 모서리 둥글게 조절
              ),
              child: Text(value),
            ),
          );
        }).toList();
      },
      child: Container(
        //padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                dropdownValue,
                style: const TextStyle(color: Colors.black),
              ),
            ),
            const Icon(Icons.arrow_drop_down, size: 40, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

class nextbutton_area extends StatelessWidget {
  const nextbutton_area({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const loginagree()),
          );
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: WHITE,
          backgroundColor: PRIMARY_COLOR,
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
