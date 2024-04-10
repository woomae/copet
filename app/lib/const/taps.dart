import 'package:flutter/material.dart';
import 'package:pet/main/main_home.dart';
import 'package:pet/main/main_screen.dart';
import 'package:pet/pages/community/community_main.dart';
import 'package:pet/pages/profile/profile_main.dart';

class TabInfo {
  final IconData icon;
  final String label;
  final screen;

  const TabInfo({
    required this.icon,
    required this.label,
    this.screen
  });
}

const TABS = [
  TabInfo(
    icon: Icons.cruelty_free,
    label: '홈',
    screen : mainscreen()
  ),
  TabInfo(
    icon: Icons.chat,
    label: '커뮤니티',
    screen: Community()
  ),
  TabInfo(
    icon: Icons.search,
    label: '펫플레이스',
  ),
  TabInfo(
    icon: Icons.place,
    label: '지도',
  ),
  TabInfo(
    icon: Icons.account_circle_outlined,
    label: '내정보',
    screen: ProfileMain()
  ),
];