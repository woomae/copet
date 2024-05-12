import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../style/colors.dart';

class DropDownButton extends StatefulWidget {
  //givenItem이 null이면 선택하지 않은걸로 간주 => 지역선택
  //givenItem이 있으면 선택 => provider update
  final String? givenItem;
  final Function? onPressed;
  final List DropDownList;

  const DropDownButton({
    super.key, required this.DropDownList, this.onPressed, this.givenItem});

  @override
  State<DropDownButton> createState() => _DropDownButtonState();
}

class _DropDownButtonState extends State<DropDownButton> {
  bool isPressed = false;
  late var currentItem = widget.DropDownList[0];

  void onPressDropDown(){
    setState(() {
      isPressed = !isPressed;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: GestureDetector(
        onTap: (){
          onPressDropDown();
        },
        child: Container(
          width: 160,
          height: isPressed ? 140 : 50,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(width: 1, color: GREY_BORDER)
          ),
          child: Row(
            children: [
              if (isPressed)
                Flexible(
                  fit: FlexFit.tight,
                  child: SingleChildScrollView(
                    child: Column(
                      children: widget.DropDownList.map(
                              (e) => SizedBox(
                                  width: double.infinity,
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                        foregroundColor: BLACK,
                                        splashFactory: NoSplash.splashFactory
                                    ),
                                    child: Text(e, style: Theme.of(context).textTheme.bodyMedium,),
                                    onPressed: (){
                                      if(widget.onPressed != null){
                                        widget.onPressed!(e);
                                      }
                                    setState(() {
                                      isPressed = !isPressed;
                                      currentItem = e;
                                    });
                                  },))).toList(),
                    ),
                  ),
                ) else Flexible(
                  fit: FlexFit.tight,
                  child: Center(child: Text(widget.givenItem != null ? widget.givenItem : currentItem ))),
              Icon(Icons.arrow_drop_down_rounded)
            ],
          ),
        ),
      ),
    );
  }
}