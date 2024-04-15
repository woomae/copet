import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../style/colors.dart';

class DropDownButton extends StatefulWidget {
  final List DropDownList;

  const DropDownButton({
    super.key, required this.DropDownList});

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
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: GestureDetector(
        onTap: (){
          onPressDropDown();
        },
        child: Container(
          width: 150,
          height: isPressed ? 150 : 50,
          padding: EdgeInsets.all(10),
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
                                    setState(() {
                                      isPressed = !isPressed;
                                      currentItem = e;
                                    });
                                  },))).toList(),
                    ),
                  ),
                ) else Flexible(
                  fit: FlexFit.tight,
                  child: Center(child: Text(currentItem))),
              Icon(Icons.arrow_drop_down_rounded)
            ],
          ),
        ),
      ),
    );
  }
}