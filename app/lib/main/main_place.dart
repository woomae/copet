import 'package:flutter/material.dart';
import 'package:pet/main/main_home.dart';
import '../common/component/buttons/dropdown_button.dart';
import '../const/regions/regions.dart';

class mainplace extends StatefulWidget {
  const mainplace({super.key});

  @override
  _mainplaceState createState() => _mainplaceState();
}

class _mainplaceState extends State<mainplace> {
  String? selectedProvince; // 선택된 시도
  String? selectedDistrict; // 선택된 구

  @override
  Widget build(BuildContext context) {
    // 시도 리스트 생성
    List<String> provinces = regionMap.keys.toList();

    // 선택된 시도에 따라 구 리스트 생성
    List<String> districts = selectedProvince != null ? regionMap[selectedProvince!]! : [];

    // 검색 결과 예시 데이터
    List<Map<String, String>> results = List.generate(10, (index) => {
      'title': '검색 결과 단어 $index',
      'description': '위치 혹은 짧은 소개글 $index',
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            pinned: true,
            elevation: 0,
            title: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'COPET',
                  style: TextStyle(
                    fontFamily: 'Poetsen',
                    color: Colors.black,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
            leading: IconButton(
              icon: Icon(
                Icons.navigate_before,
                color: Colors.black,
              ),
              iconSize: 40,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            centerTitle: false,
            shape: Border(
              bottom: BorderSide(
                color: Color(0xFFE6E6E6),
                width: 1,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: DropDownButton(
                            dropDownList: provinces,
                            currentItem: selectedProvince ?? '지역선택', // 기본값 설정
                            onPressed: (value) {
                              setState(() {
                                selectedProvince = value; // 선택된 시도 저장
                                selectedDistrict = null; // 구 초기화
                              });
                            },
                            width: MediaQuery.of(context).size.width * 0.45, // 드롭다운 너비 설정
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: DropDownButton(
                            dropDownList: districts.isNotEmpty ? districts : ['지역선택'], // 선택된 시도의 구 리스트
                            currentItem: selectedDistrict ?? '지역선택', // 구 기본값 설정
                            onPressed: (value) {
                              setState(() {
                                selectedDistrict = value; // 선택된 구 저장
                              });
                            },
                            width: MediaQuery.of(context).size.width * 0.4, // 드롭다운 너비 설정
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  SingleChildScrollView(
                    child: Container(
                      width: double.infinity,
                      height: 8,
                      decoration: BoxDecoration(
                        color: Color(0xFFF2F2F2),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  // 검색 결과 리스트
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(), // 스크롤 방지
                    itemCount: results.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          // 항목 클릭 시 행동
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                          child: Row(
                            children: [
                              Image.asset(
                                'asset/img/img_place.png',
                                width: 100, // 이미지 너비 조정
                                height: 100, // 이미지 높이 조정
                              ),
                              SizedBox(width: 15), // 이미지와 텍스트 사이 간격 조정
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    results[index]['title']!, // 제목 표시
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontFamily: 'NotoSansKR',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    results[index]['description']!, // 설명 표시
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
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
