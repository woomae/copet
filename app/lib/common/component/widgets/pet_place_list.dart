import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet/const/models/pet_place.dart';

class PetPlaceList extends StatelessWidget {
  final PetPlaces petPlaces;
  final int length;
  const PetPlaceList({super.key, required this.petPlaces, required this.length});

  @override
  Widget build(BuildContext context) {
    final petPlaceList = petPlaces.row;
    return Column(
        children: petPlaceList.take(length).map((e)=>
            Column(
              children: [
                InkWell(
                  onTap: () {},
                  child: Container(
                    child: Row(
                      children: [
                        Image.network(
                          fit: BoxFit.cover,
                          e.imgName,
                          width: 100, // 이미지 너비 조정
                          height: 100, // 이미지 높이 조정
                        ),
                        SizedBox(width: 15), // 이미지와 텍스트 사이 간격 조정
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              e.title,
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontFamily: 'NotoSansKR',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              e.region,
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFFC9C9C9),
                                fontFamily: 'NotoSansKR',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10)
              ],
            )
        ).toList()
    );;
  }
}
