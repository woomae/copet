import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet/common/component/appbars/go_back_appbar.dart';
import 'package:pet/common/component/buttons/next_button.dart';
import 'package:pet/common/component/region_dropdown_widget.dart';
import 'package:pet/const/regions/region_list.dart';
import 'package:pet/pages/profile/profile_main.dart';
import '../../common/component/buttons/dropdown_button.dart';
import '../../style/colors.dart';

class ProfileModify extends StatelessWidget {
  const ProfileModify({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GoBackAppBar(),
      body: _Body(),
    );
  }
}

class _Body extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  Stack(
      children: [
        Container(
          color: GREY2,
        ),
        const Padding(
          padding: EdgeInsets.only(top: 120),
          child: Profile(childWidget: ModifyContainer(),),
        ),
      ],
    );
  }
}

class ModifyContainer extends StatefulWidget {
  const ModifyContainer({super.key});

  @override
  State<ModifyContainer> createState() => _ModifyContainerState();
}

class _ModifyContainerState extends State<ModifyContainer> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(left: 15, right: 15, bottom: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InputField(text: '닉네임', hintText: '* 닉네임은 언제든지 변경이 가능합니다.',),
              ],
            ),
            InputField(text: '자기소개', hintText: '* 60자 이내',),
            RegionDropdownWidget(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Nextbutton( //수정 요청 보낸 후 제대로 응답이 도착했는지 확인하는 에러처리 필요
                //   onPressed: () => Navigator.pop(context),
                // )
              ],
            )
            ]
        )
      ),
    );
  }
}

class InputField extends StatelessWidget {

  final String text;
  final String hintText;

  const InputField({
    super.key,
    required this.text,
    required this.hintText
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(text, style: Theme.of(context).textTheme.bodyMedium,),
          SizedBox( height: 5,),
          textformfield_modify(
            onChanged: (value) {
              // Handle changes here
            },
            text: text,
            hintText: hintText,
          ),
          SizedBox(height: 5,),
          Text(hintText, style: Theme.of(context).textTheme.labelMedium,)
        ],
      ),
    );
  }
}

class textformfield_modify extends StatelessWidget {
  final String? text;
  final Function onChanged;
  final String hintText;

  textformfield_modify({
    super.key,
    required this.onChanged,
    this.text,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController(text: text != null ? text : '');
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: controller,
            onChanged: (e) => onChanged(e),
            cursorColor: Colors.black,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                borderSide: BorderSide(width: 1, color: Colors.grey),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: Colors.grey),
              ),
              isDense: true,
              contentPadding: EdgeInsets.all(5),
            ),
          ),
          if (hintText.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                hintText,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                ),
              ),
            ),
        ],
      ),
    );
  }
}