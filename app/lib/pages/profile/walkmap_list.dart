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
          return GestureDetector(
            onTap: (){
              showDialog(context: context, builder: (BuildContext context){
                return AlertDialog(
                  contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  actions: <Widget>[
                    walkMap[index].photo != null
                        ? SizedBox(child:  Image.network(walkMap[index].photo!),)
                        : SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                      Container(
                        child: Column(children: [
                          Text(walkMap[index].durationSeconds.toString()+"초",
                            style: Theme.of(context).textTheme.titleLarge,),
                          Text('산책 시간', style: Theme.of(context).textTheme.labelMedium,)
                        ],),
                      ),
                      Container(
                        child: Column(children: [
                          Text(walkMap[index].steps.toString() ,
                            style: Theme.of(context).textTheme.titleLarge,),
                          Text('걸음 수', style: Theme.of(context).textTheme.labelMedium,)
                        ],),
                      )
                    ],)
                  ],
                );
              });
            },
            child: Container(
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
                            child: walkMap[index].photo != null
                                ? Image.network(walkMap[index].photo!)
                                :Container(width: 50,height: 50, color: GREY2,))),
                    SizedBox(height: 3),
                    Text(formatDateToYYYYMMDD(walkMap[index].createdAt), style: Theme.of(context).textTheme.labelMedium,)
                  ],
                ),
              ),
            ),
          );
        });;
  }
}
