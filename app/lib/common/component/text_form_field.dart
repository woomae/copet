import 'package:flutter/material.dart';

class textformfield extends StatelessWidget {
  final String? text;
  final Function onChanged;
  textformfield({
    super.key,
    required this.onChanged,
    this.text
  });


  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController(text: text !=null ? text : '');
    return Padding(
      padding: const EdgeInsets.all(20),
      child: TextFormField(
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
    );
  }
}
