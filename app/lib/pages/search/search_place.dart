import 'package:flutter/material.dart';
import 'package:pet/pages/search/search_result.dart';

import '../../api/mocks/getPetPlace.dart';
import '../../common/component/widgets/pet_place_list.dart';
import '../../const/models/pet_place.dart';

class result_place extends StatelessWidget {
  const result_place({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            pinned: true,
            elevation: 0,
            title: Text(
              '플레이스 - 검색 결과',
              style: TextStyle(
                fontFamily: 'Segoe',
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: IconButton(
              icon: Icon(
                Icons.navigate_before,
                color: Colors.black,
              ),
              iconSize: 40,
              onPressed: () {
                Navigator.pop(context); // 뒤로 가기 기능
              },
            ),
            centerTitle: true, // title을 가운데 정렬
            titleSpacing: 0, // 좌우 여백 없앰
            shape: Border(
              bottom: BorderSide(
                color: Color(0xFFE6E6E6),
                width: 1,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: FutureBuilder<PetPlaces>(future: getPetPlace(), builder: (BuildContext context, snapshot){
                if(snapshot.hasError) {
                  print(snapshot.error);
                  return SizedBox();
                }
                if(snapshot.hasData){
                  return PetPlaceList(petPlaces: snapshot.data!, length: snapshot.data!.count);
                }
                else{
                  return SizedBox();
                }
              }),
            ),
          )
        ],
      ),
    );
  }
}
