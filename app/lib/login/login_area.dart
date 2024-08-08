import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet/common/component/buttons/dropdown_button.dart';
import 'package:pet/login/login_agree.dart';
import 'package:pet/style/colors.dart';

const Map<String, List<String>> regionMap = {
  '서울특별시': ['종로구', '중구', '용산구', '성동구'],
  '인천광역시': ['중구', '동구', '미추홀구', '연수구'],
  '대구광역시': ['중구', '동구', '서구', '남구'],
  '대전광역시': ['동구', '중구', '서구', '유성구'],
  '울산광역시': ['중구', '남구', '동구', '북구'],
  '부산광역시': ['중구', '서구', '동구', '영도구'],
  '광주광역시': ['동구', '서구', '남구', '북구', '광산구'],
};

const Map<String, Map<String, List<String>>> dongMap = {
  '서울특별시': {
    '종로구': ['종로1가', '종로2가', '종로3가'],
    '중구': ['중1가', '중2가', '중3가'],
    '용산구': ['용산1가', '용산2가', '용산3가'],
    '성동구': ['성동1가', '성동2가', '성동3가'],
  },
  '인천광역시': {
    '중구': ['인천중1가', '인천중2가', '인천중3가'],
    '동구': ['인천동1가', '인천동2가', '인천동3가'],
    '미추홀구': ['미추홀1가', '미추홀2가', '미추홀3가'],
    '연수구': ['연수1가', '연수2가', '연수3가'],
  },
  '대구광역시': {
    '중구': ['대구중1가', '대구중2가', '대구중3가'],
    '동구': ['대구동1가', '대구동2가', '대구동3가'],
    '서구': ['대구서1가', '대구서2가', '대구서3가'],
    '남구': ['대구남1가', '대구남2가', '대구남3가'],
  },
  '대전광역시': {
    '동구': ['대전동1가', '대전동2가', '대전동3가'],
    '중구': ['대전중1가', '대전중2가', '대전중3가'],
    '서구': ['대전서1가', '대전서2가', '대전서3가'],
    '유성구': ['유성1가', '유성2가', '유성3가'],
  },
  '울산광역시': {
    '중구': ['울산중1가', '울산중2가', '울산중3가'],
    '남구': ['울산남1가', '울산남2가', '울산남3가'],
    '동구': ['울산동1가', '울산동2가', '울산동3가'],
    '북구': ['울산북1가', '울산북2가', '울산북3가'],
  },
  '부산광역시': {
    '중구': ['부산중1가', '부산중2가', '부산중3가'],
    '서구': ['부산서1가', '부산서2가', '부산서3가'],
    '동구': ['부산동1가', '부산동2가', '부산동3가'],
    '영도구': ['영도1가', '영도2가', '영도3가'],
  },
  '광주광역시': {
    '동구': ['광주동1가', '광주동2가', '광주동3가'],
    '서구': ['광주서1가', '광주서2가', '광주서3가'],
    '남구': ['광주남1가', '광주남2가', '광주남3가'],
    '북구': ['광주북1가', '광주북2가', '광주북3가'],
    '광산구': ['광산1가', '광산2가', '광산3가'],
  },
};

final regionProvider = StateProvider<String>((ref) => '지역선택');
final districtProvider = StateProvider<String>((ref) => '지역선택');
final dongProvider = StateProvider<String>((ref) => '지역선택');

class loginarea extends ConsumerWidget {
  const loginarea({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedRegion = ref.watch(regionProvider);
    final selectedDistrict = ref.watch(districtProvider);
    final selectedDong = ref.watch(dongProvider);

    List<String> districts = selectedRegion != '지역선택' ? regionMap[selectedRegion]! : ['지역선택'];
    List<String> dongs = (selectedRegion != '지역선택' && selectedDistrict != '지역선택')
        ? dongMap[selectedRegion]![selectedDistrict]!
        : ['지역선택'];

    // Determine if the "Next" button should be enabled
    bool isButtonEnabled = selectedRegion != '지역선택' &&
        selectedDistrict != '지역선택' &&
        selectedDong != '지역선택';

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
                      currentItem: selectedRegion,
                      onPressed: (value) {
                        ref.read(regionProvider.notifier).state = value;
                        ref.read(districtProvider.notifier).state = '지역선택';
                        ref.read(dongProvider.notifier).state = '지역선택';
                      },
                      width: 350,
                      height: 150,
                      borderRadius: 20,
                      borderColor: Color(0xFF777777),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DropDownButton(
                          dropDownList: districts,
                          currentItem: selectedDistrict,
                          onPressed: (value) {
                            ref.read(districtProvider.notifier).state = value;
                            ref.read(dongProvider.notifier).state = '지역선택';
                          },
                          width: 180,
                          height: 150,
                          borderRadius: 20,
                          borderColor: Color(0xFF777777),
                        ),
                        const SizedBox(width: 20),
                        DropDownButton(
                          dropDownList: dongs,
                          currentItem: selectedDong,
                          onPressed: (value) {
                            ref.read(dongProvider.notifier).state = value;
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
            nextbutton_area(isEnabled: isButtonEnabled),
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

class nextbutton_area extends StatelessWidget {
  final bool isEnabled;
  const nextbutton_area({super.key, required this.isEnabled});

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
