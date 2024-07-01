import 'package:flutter/material.dart';

class textformfield extends StatelessWidget {
  final String? text;
  final Function onChanged;
  final String hintText;

  textformfield({
    super.key,
    required this.onChanged,
    this.text
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController(text: text);
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
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
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