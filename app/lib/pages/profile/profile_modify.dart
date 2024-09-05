import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet/common/component/appbars/modify_appbar.dart';
import '../../common/component/buttons/dropdown_button.dart';
import '../../providers/user_notifier_provider.dart';
import '../../style/colors.dart';
import 'package:pet/login/login_area.dart';
import 'package:pet/const/regions/regions.dart';
import 'package:pet/providers/user_data_notifier_provider.dart'; // UserDataProvider import 추가

class ProfileModify extends ConsumerStatefulWidget {
  const ProfileModify({super.key});

  @override
  _ProfileModifyState createState() => _ProfileModifyState();
}

class _ProfileModifyState extends ConsumerState<ProfileModify> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ModifyAppBar(context),
      body: _Body(),
    );
  }
}

class _Body extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.invalidate(userDataProvider); //수정 페이지 이탈 시 userDataProvider 초기화
    return Stack(
      children: [
        Container(
          height: 147,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFFFFFFF), // 완전 불투명한 흰색
                Color(0xFFFFEECC), // 연한 주황색
              ],
              stops: [0.0, 1.0], // 각 색상이 위치하는 비율
              begin: Alignment.topCenter, // 그라데이션 시작점 (왼쪽 위)
              end: Alignment.bottomCenter, // 그라데이션 끝점 (오른쪽 아래)
            ),
          ),
        ),
        Container(
          height: 147,
          color: Color(0xFF000000).withOpacity(0.1), // 10% 투명도 검정색
        ),
        const Padding(
          padding: EdgeInsets.only(top: 120),
          child: Profile_modify(childWidget: ModifyContainer()),
        ),
      ],
    );
  }
}

class ModifyContainer extends StatelessWidget {
  const ModifyContainer({Key? key});

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 100),
        child: Column(
          children: [
            Consumer(builder: (BuildContext context, WidgetRef ref, Widget){
              final user = ref.read(UserProvider); // userData를 가져옵니다
              final petCategory = user.petCategory;
              final nickname = user.nickname; // 닉네임을 가져옵니다
              final intro = user.intro; // 자기소개를 가져옵니다
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                _title(text: '닉네임'),
                InputField(
                  hintText: '* 닉네임은 언제든지 변경이 가능합니다.',
                  showHintText: false,
                  initialText: nickname ?? '', // 닉네임을 초기값으로 설정합니다
                  onChanged: (value) {
                    ref.read(userDataProvider.notifier).updateUserData(nickname: value);
                  },
                ),
                _title(text: '자기소개'),
                InputField(
                  hintText: '* 60자 이내',
                  showHintText: true,
                  initialText: intro ?? '', // 자기소개 초기값 설정
                  onChanged: (value) {
                    ref.read(userDataProvider.notifier).updateUserData(intro: value);
                  },
                ),
                _title(text: '반려동물 종'),
                InputField(
                  hintText: '골든리트리버',
                  showHintText: false,
                  initialText: petCategory ?? '', // 반려동물 종 초기값 설정
                  onChanged: (value) {
                    ref.read(userDataProvider.notifier).updateUserData(pet_category: value);
                  },
                ),
                _title(text: '지역 설정'),
              ],);
            }),
            Consumer(builder: (BuildContext context, WidgetRef ref, Widget){
              final user = ref.read(UserProvider); // userData를 가져옵니다
              final userData = ref.watch(userDataProvider);
              final String? selectedState = userData.region?.state ?? user.region.state;
              final String? selectedCity = userData.region?.city ??user.region.city;
              final String? selectedDistrict = userData.region?.district ?? user.region.district;

              List<String> cities = selectedState != '지역선택' ? regionMap[selectedState]! : ['지역선택'];
              List<String> districts = (selectedState != '지역선택' && selectedCity != '지역선택')
                  ? dongMap[selectedState]![selectedCity]!
                  : ['지역선택'];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                DropDownButton(
                  dropDownList: ['지역선택'] + regionMap.keys.toList(),
                  currentItem: selectedState,
                  onPressed: (value) {
                    ref.read(userDataProvider.notifier).updateUserData(state_: value);
                    ref.read(userDataProvider.notifier).updateUserData(city: '지역선택');
                    ref.read(userDataProvider.notifier).updateUserData(district: '지역선택');
                  },
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      child: DropDownButton(
                        dropDownList: cities,
                        currentItem: selectedCity,
                        onPressed: (value) {
                          ref.read(userDataProvider.notifier).updateUserData(city: value);
                          ref.read(userDataProvider.notifier).updateUserData(district: '지역선택');
                        },
                      ),
                    ),
                    const SizedBox(width: 15),
                    Flexible(
                      fit: FlexFit.tight,
                      child: DropDownButton(
                        dropDownList: districts,
                        currentItem: selectedDistrict,
                        onPressed: (value) {
                          ref.read(userDataProvider.notifier).updateUserData(district: value);
                        },
                      ),
                    ),
                  ],
                ),
              ]);
            })
          ],
        ),
      ),
    );
  }
}

class InputField extends StatelessWidget {
  final String hintText;
  final bool showHintText;
  final String initialText; // 추가된 부분
  final Function(String) onChanged;

  const InputField({
    Key? key,
    required this.hintText,
    required this.showHintText,
    this.initialText = '', // 초기값 설정
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 45.0,
            child: textformfield_modify(
              onChanged: onChanged,
              hintText: showHintText ? hintText : null,
              initialText: initialText, // 초기값 전달
            ),
          ),
          if (showHintText)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  hintText,
                  style: TextStyle(
                    fontFamily: 'Segoe',
                    fontSize: 16,
                    color: Color(0xFFB0B0B0),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class textformfield_modify extends StatelessWidget {
  final String? text;
  final Function(String) onChanged;
  final String? hintText;
  final String? initialText; // 추가된 부분

  textformfield_modify({
    Key? key,
    required this.onChanged,
    this.text,
    this.hintText,
    this.initialText, // 추가된 부분
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller =
    TextEditingController(text: initialText ?? text ?? ''); // 초기값 설정
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          onChanged: (e) => onChanged(e),
          cursorColor: Colors.black,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              borderSide: BorderSide(width: 1, color: Color(0xFFB0B0B0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              borderSide: BorderSide(width: 1, color: Color(0xFFB0B0B0)),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Color(0xFFB0B0B0)),
            ),
            isDense: true,
            contentPadding: EdgeInsets.all(10), // 내부 여백 설정
          ),
        ),
      ],
    );
  }
}

class _title extends StatelessWidget {
  final String text;

  const _title({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontFamily: 'Segoe',
          fontWeight: FontWeight.w400,
          color: Color(0xFF222222),
        ),
      ),
    );
  }
}

class Profile_modify extends StatefulWidget {
  final Widget childWidget;

  const Profile_modify({Key? key, required this.childWidget}) : super(key: key);

  @override
  _Profile_modifyState createState() => _Profile_modifyState();
}

class _Profile_modifyState extends State<Profile_modify> {
  File? _image;

  Future<void> _pickImage(WidgetRef ref) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        ref.read(userDataProvider.notifier).updateUserData(photo: _image?.path);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _image = null;
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.only(top: 50),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(40),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.25),
                blurRadius: 2,
                offset: Offset(0, -4),
              ),
            ],
          ),
          child: widget.childWidget,
        ),
        Positioned(
          top: -50,
          child: Consumer(builder: (BuildContext context, WidgetRef ref, Widget){
            final user = ref.read(UserProvider);
            return GestureDetector(
              onTap: ()=>_pickImage(ref),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.25),
                          blurRadius: 2,
                          spreadRadius: -1,
                          offset: Offset(0, -6),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(150),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      child: _image != null
                          ? Image.file(_image!, fit: BoxFit.cover)
                          : Image.asset('asset/img/Yaoh.png'),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: ClipRRect(
                      child: GestureDetector(
                        onTap: ()=> _pickImage(ref),
                        child: Image.asset('asset/img/profile/img_modify.png'),
                      ),
                    ),
                  ),
                ],
              ),
            );
          })
        ),
      ],
    );
  }
}
