import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommonDialog extends StatelessWidget {
  final String content;
  const CommonDialog({
    super.key,
    required this.content
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
      ),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(content, style: Theme.of(context).textTheme.bodyLarge,),
          ),
        ],
      ),
    );
  }
}
