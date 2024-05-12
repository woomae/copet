import 'package:flutter/material.dart';

class textformfield extends StatelessWidget {
  final Function onChanged;
  const textformfield({
    super.key,
    required this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: TextFormField(
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
