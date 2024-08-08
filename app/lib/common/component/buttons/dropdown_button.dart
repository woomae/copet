import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../style/colors.dart';

class DropDownButton extends StatefulWidget {
  final String? currentItem;
  final Function? onPressed;
  final List dropDownList;
  final double? width;
  final double? height;
  final double? borderRadius;
  final Color? borderColor;

  const DropDownButton({
    super.key,
    required this.dropDownList,
    this.onPressed,
    this.currentItem,
    this.width,
    this.height,
    this.borderRadius,
    this.borderColor,
  });

  @override
  State<DropDownButton> createState() => _DropDownButtonState();
}

class _DropDownButtonState extends State<DropDownButton> {
  bool isPressed = false;

  void onPressDropDown() {
    setState(() {
      isPressed = !isPressed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressDropDown();
      },
      child: Container(
        width: widget.width ?? 160,
        height: isPressed ? (widget.height ?? 140) : 45,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
          border: Border.all(width: 1, color: widget.borderColor ?? GREY_BORDER),
        ),
        child: Row(
          children: [
            if (isPressed)
              Flexible(
                fit: FlexFit.tight,
                child: SingleChildScrollView(
                  child: Column(
                    children: widget.dropDownList.map(
                          (e) => SizedBox(
                        width: double.infinity,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: BLACK,
                            splashFactory: NoSplash.splashFactory,
                          ),
                          child: Text(e, style: Theme.of(context).textTheme.bodyMedium),
                          onPressed: () {
                            if (widget.onPressed != null) {
                              widget.onPressed!(e);
                            }
                            setState(() {
                              isPressed = !isPressed;
                            });
                          },
                        ),
                      ),
                    ).toList(),
                  ),
                ),
              )
            else
              Flexible(
                fit: FlexFit.tight,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(widget.currentItem != null ? widget.currentItem! : widget.dropDownList[0]),
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Image.asset(
                'asset/img/downbutton.png',
                width: 24, // 이미지 너비 설정
                height: 24, // 이미지 높이 설정
              ),
            ),
          ],
        ),
      ),
    );
  }
}
