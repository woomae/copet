import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet/const/models/walkmap_model.dart';

import '../../style/colors.dart';
import '../../utils/format_date.dart';

class WalkmapList extends StatelessWidget {
  final List<WalkMap> walkMap;
  const WalkmapList({super.key, required this.walkMap});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: 3,
        padding: EdgeInsets.only(top: 10),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemBuilder: (BuildContext context, int index){
          return Container(
            decoration: BoxDecoration(
                border: Border(right: BorderSide(width: 1, color: GREY2), bottom: BorderSide(width: 1, color: GREY2))
            ),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: AspectRatio(
                          aspectRatio: 1,
                          child: Image.network(walkMap[index].photo!))),
                  SizedBox(height: 3),
                  Text(formatDateToYYYYMMDD(walkMap[index].createdAt), style: Theme.of(context).textTheme.labelMedium,)
                ],
              ),
            ),
          );
        });;
  }
}
