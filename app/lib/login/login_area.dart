import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet/common/component/buttons/dropdown_button.dart';
import 'package:pet/const/models/user_data_model.dart';
import 'package:pet/const/regions/jellanamdo/jeollanamdo.dart';
import 'package:pet/const/regions/region_list.dart';
import 'package:pet/login/login_agree.dart';
import 'package:pet/style/colors.dart';
import 'package:pet/const/regions/regions.dart';

final stateProvider = StateProvider<String>((ref) => '지역선택');
final cityProvider = StateProvider<String>((ref) => '지역선택');
final districtProvider = StateProvider<String>((ref) => '지역선택');

class loginarea extends ConsumerWidget {
  loginarea({super.key});
  // district 수정 필요

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedState = ref.watch(stateProvider);
    final selectedCity = ref.watch(cityProvider);
    final selectedDistrict = ref.watch(districtProvider);

    List<String> cities = selectedState != '지역선택' ? regionMap[selectedState]! : ['지역선택'];
    List<String> districts = (selectedState != '지역선택' && selectedCity != '지역선택')
        ? dongMap[selectedState]![selectedCity]!
        : ['지역선택'];

    // Determine if the "Next" button should be enabled
    bool isButtonEnabled = selectedState != '지역선택' &&
        selectedCity != '지역선택' &&
        selectedDistrict != '지역선택';

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30),
              child: _Title(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Center(
                child: Column(
                  children: [
                    DropDownButton(
                      dropDownList: ['지역선택'] + regionMap.keys.toList(),
                      currentItem: selectedState,
                      onPressed: (value) {
                        ref.read(stateProvider.notifier).state = value;
                        ref.read(cityProvider.notifier).state = '지역선택';
                        ref.read(districtProvider.notifier).state = '지역선택';
                      },
                      width: 350,
                      height: 200,
                      borderRadius: 20,
                      borderColor: Color(0xFF777777),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DropDownButton(
                          dropDownList: cities,
                          currentItem: selectedCity,
                          onPressed: (value) {
                            ref.read(cityProvider.notifier).state = value;
                            ref.read(districtProvider.notifier).state = '지역선택';
                          },
                          width: 180,
                          height: 150,
                          borderRadius: 20,
                          borderColor: Color(0xFF777777),
                        ),
                        const SizedBox(width: 20),
                        DropDownButton(
                          dropDownList: districts,
                          currentItem: selectedDistrict,
                          onPressed: (value) {
                            ref.read(districtProvider.notifier).state = value;
                          },
                          width: 153,
                          height: 150,
                          borderRadius: 20,
                          borderColor: Color(0xFF777777),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
            NextButtonArea(isEnabled: isButtonEnabled),
          ],
        ),
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

class NextButtonArea extends StatelessWidget {
  final bool isEnabled;
  const NextButtonArea({super.key, required this.isEnabled});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ElevatedButton(
        onPressed: isEnabled
            ? () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const loginagree()),
          );
        }
            : null, // Disable button if not enabled
        style: ElevatedButton.styleFrom(
          foregroundColor: WHITE,
          backgroundColor: isEnabled ? PRIMARY_COLOR : Color(0xFFB0B0B0), // Change color based on enabled state
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
