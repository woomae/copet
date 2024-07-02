import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet/api/getArticles.dart';
import 'package:pet/common/component/appbars/appbar.dart';
import 'package:pet/pages/community/post_list.dart';
import 'package:pet/pages/community/posting_page.dart';
import 'package:pet/style/colors.dart';
import '../../const/models/articles.dart';

final selectedCategoryProvider = StateNotifierProvider<CategoryNotifier, String?>((ref) {
  return CategoryNotifier();
});

class CategoryNotifier extends StateNotifier<String?> {
  CategoryNotifier() : super(null);

  void selectCategory(String category) {
    if (state == category) {
      state = null; // Deselect the category if it is already selected
    } else {
      state = category;
    }
  }
}

//ListView.builder 활용해서 무한스크롤 구현?
class Community extends ConsumerWidget {
  const Community({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final articlesProvider = StateProvider<Future<List<Comments>>>(
        (ref) => GetArticles.getArticles());
    final articles = ref.watch(articlesProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.white,
                pinned: true,
                elevation: 0,
                title: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    '커뮤니티',
                    style: TextStyle(
                      fontFamily: 'SnowCrap',
                      color: Colors.black,
                      fontSize: 25,
                    ),
                  ),
                ),
                centerTitle: false,
                actions: [
                  InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: Image.asset(
                        'asset/img/alarm.png', // 원하는 이미지의 경로
                        width: 18.0, // 이미지의 너비
                        height: 19.38, // 이미지의 높이
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: EdgeInsets.only(right: 30),
                      child: Image.asset(
                        'asset/img/mail.png', // 원하는 이미지의 경로
                        width: 22.0, // 이미지의 너비
                        height: 16.5, // 이미지의 높이
                      ),
                    ),
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                          top: 40, bottom: 36, left: 10, right: 10),
                      decoration: BoxDecoration(
                        color: WHITE,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Category(categoryName: '일상', isSelected: selectedCategory == '일상'),
                            Category(categoryName: '도움', isSelected: selectedCategory == '도움'),
                            Category(categoryName: 'Q&A', isSelected: selectedCategory == 'Q&A'),
                            Category(categoryName: '정보후기', isSelected: selectedCategory == '정보후기'),
                          ],
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Container(
                        width: double.infinity,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              'asset/img/main/banner.png', // 이미지 경로
                              width: double.infinity,
                              height: 100,
                              fit: BoxFit.fill, // 이미지를 컨테이너에 맞추기 위해 사용
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 400, // 적절한 높이 설정
                      child: Stack(
                        children: [
                          RefreshIndicator(
                            onRefresh: () {
                              final newFuture = GetArticles.getArticles();
                              ref.read(articlesProvider.notifier).state =
                                  newFuture;
                              return newFuture;
                            },
                            child: FutureBuilder(
                              future: articles,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(child: Text('로딩 중'));
                                }
                                if (snapshot.hasData) {
                                  return PostList(
                                      length: snapshot.data!.length,
                                      comments: snapshot.data!);
                                } else {
                                  return Center(child: Text('error'));
                                }
                              },
                            ),
                          ),
                          // Align(
                          //   alignment: Alignment.bottomCenter,
                          //   child: Container(
                          //       width: 140,
                          //       height: 50,
                          //       child: PostButton()),
                          // )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 100),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  width: 140, height: 50, child: PostButton()),
            ),
          )
        ],
      ),
    );
  }
}

class Category extends ConsumerWidget {
  final String categoryName;
  final bool isSelected;

  const Category({super.key, required this.categoryName, required this.isSelected});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: GestureDetector(
        onTap: () {
          ref.read(selectedCategoryProvider.notifier).selectCategory(categoryName);
          print('Category Pessed');
        },
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.25 - 20,
              height: 40,
              decoration: BoxDecoration(
                color: isSelected ? Colors.orange : Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: isSelected ? Colors.orange : Color(0xFFE7E7E7),
                  width: 0.5, // 테두리 두께
                ),
              ),
              child: Center(
                child: Text(
                  categoryName,
                  style: TextStyle(
                    fontFamily: 'Segoe',
                    fontSize: 15,
                    color: isSelected ? Colors.white : Color(0xFFE7E7E7),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PostButton extends StatelessWidget {
  const PostButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: PRIMARY_COLOR,
        splashFactory: NoSplash.splashFactory,
        foregroundColor: BLACK,
      ),
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const PostingPage()));
      },
      child: Text(
        '글쓰기',
        style: TextStyle(
          fontFamily: 'Segoe',
          fontSize: 16,
          color: Colors.white,
        ),
      ),
    );
  }
}
