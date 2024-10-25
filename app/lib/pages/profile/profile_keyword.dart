import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pet/common/component/keyword/keyword.dart';
import 'package:pet/login/login_end.dart';
import 'package:pet/pages/profile/profile_main.dart';
import 'package:pet/providers/user_data_notifier_provider.dart';
import 'package:pet/providers/user_notifier_provider.dart';

import '../../api/users/patchUserData.dart';
import '../../style/colors.dart';

class profile_keyword extends ConsumerStatefulWidget {
  const profile_keyword({super.key});

  @override
  ConsumerState<profile_keyword> createState() => _profile_keywordState();
}

class _profile_keywordState extends ConsumerState<profile_keyword> {
  final Set<int> selectedIndexes = {};
  late List<String> keywordNames = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userData = ref.read(userDataProvider).petkeyword;
      if (userData != null) {
        setState(() {
          for (var i = 0; i < keywords.length; i++) {
            if (userData.contains(keywords[i].name)) {
              selectedIndexes.add(i);
            }
          }
        });
      }
    });
  }

  void onKeywordTap(int index, WidgetRef ref) {
    setState(() {
      if (selectedIndexes.contains(index)) {
        selectedIndexes.remove(index);
      } else {
        if (selectedIndexes.length < 3) {
          selectedIndexes.add(index);
        }
      }
      keywordNames = selectedIndexes.map((e) => keywords[e].name).toList();
      ref.read(userDataProvider.notifier).updateUserData(petkeyword: keywordNames);
    });
  }

  @override
  Widget build(BuildContext context) {
    int selectedCount = selectedIndexes.length;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer(builder: (BuildContext context, WidgetRef ref, Widget) {
        return Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.white,
                  elevation: 0,
                  pinned: true,
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back_ios, color: Colors.black),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        final user = ref.read(UserProvider);
                        final userData = ref.read(userDataProvider);
                        try {
                          PatchUserData.patchUserData(
                              nickname: userData.nickname ?? user.nickname,
                              intro: userData.intro ?? user.intro,
                              pet_category: userData.pet_category ?? user.petCategory,
                              region: userData.region?.district != '지역선택' && userData.region?.district != null
                                  ? userData.region!
                                  : user.region,
                              petkeyword: userData.petkeyword ?? user.petKeywords.map((e) => e.keyword).toList(),
                              petimg: userData.photo ?? null
                          );
                          Navigator.pop(context);
                          Navigator.pop(context);
                        } catch (e) {
                          print(e);
                        }
                      },
                      child: Text(
                        '완료',
                        style: TextStyle(
                          fontFamily: 'NotoSansKR',
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF222222),
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.white.withOpacity(0),
                            Colors.white,
                          ],
                          stops: [0.0, 0.33],
                        ),
                      ),
                    ),
                  ),
                  shape: Border(
                    bottom: BorderSide(color: Color(0xFFDEDEDE), width: 1.0),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50, bottom: 177),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _Title(),
                        const SizedBox(height: 20),
                        _SubTitle(),
                        const SizedBox(height: 20),
                        SelectedCount(selectedCount: selectedCount),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 20,
                              crossAxisSpacing: 15,
                              childAspectRatio: 0.75,
                            ),
                            itemCount: keywords.length,
                            itemBuilder: (context, index) {
                              final keyword = keywords[index];
                              final isSelected = selectedIndexes.contains(index);

                              return GestureDetector(
                                onTap: () => onKeywordTap(index, ref),
                                child: Column(
                                  children: [
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        ClipOval(
                                          child: Image.asset(
                                            keyword.imagePath,
                                            fit: BoxFit.cover,
                                            width: 100,
                                            height: 100,
                                          ),
                                        ),
                                        if (isSelected)
                                          ClipOval(
                                            child: Container(
                                              width: 100,
                                              height: 100,
                                              color: Colors.black.withOpacity(0.2),
                                              child: Center(
                                                child: Image.asset(
                                                  'asset/img/check_white.png',
                                                  width: 50,
                                                  height: 36.72,
                                                ),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                    Text(
                                      keyword.name,
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontFamily: 'Segoe',
                                        color: Colors.black,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        );
      }),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30),
      child: Text(
        '키워드 선택',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          fontFamily: 'Segoe',
          color: Colors.black,
        ),
      ),
    );
  }
}

class _SubTitle extends StatelessWidget {
  const _SubTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30),
      child: Text(
        '키워드를 선택해서 나와 반려동물에게\n더 잘 맞는 친구를 찾아보세요!',
        style: TextStyle(
          fontSize: 15,
          fontFamily: 'Segoe',
          color: Colors.black,
        ),
      ),
    );
  }
}

class SelectedCount extends StatelessWidget {
  final int selectedCount;
  const SelectedCount({super.key, required this.selectedCount});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30),
      child: Text(
        '$selectedCount/3',
        style: TextStyle(
          fontSize: 15,
          fontFamily: 'Segoe',
          color: Color(0xFF686868),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
