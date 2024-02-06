import 'package:flutter/material.dart';

class textformfield extends StatelessWidget {
  const textformfield({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: TextFormField(
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
