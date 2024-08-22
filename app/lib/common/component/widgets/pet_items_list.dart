import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet/const/models/merchandises.dart';

class PetItemsList extends StatelessWidget {
  final Merchandises merchandises;
  final int length;
  const PetItemsList({super.key, required this.merchandises, required this.length});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate:
      SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 25,
        childAspectRatio: 0.55,
      ),
      itemCount: length,
      itemBuilder: (context, index) {
        final item = merchandises.rows[index];
        return InkWell(
          onTap: () {
            // 아이템을 탭했을 때의 동작 정의
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(
                    item!.imgName,
                    width: double.infinity,
                    height: 144,
                    fit: BoxFit.cover,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 7),
                      child: Text(
                        item.name,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Color(0xFF686868),
                          fontSize: 15,
                          fontFamily: 'NotoSansKR',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Text(
                      "25,000",
                      style: TextStyle(
                        color: Color(0xFF222222),
                        fontSize: 16,
                        fontFamily: 'Segoe',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
