import 'package:flutter/material.dart';

class TabInfo {
  final IconData icon;
  final String label;

  const TabInfo({
    required this.icon,
    required this.label,
  });
}

const TABS = [
  TabInfo(
    icon: Icons.cruelty_free,
    label: '홈',
  ),
  TabInfo(
    icon: Icons.place,
    label: '장소',
  ),
  TabInfo(
    icon: Icons.search,
    label: '찾기',
  ),
  TabInfo(
    icon: Icons.chat,
    label: '채팅',
  ),
  TabInfo(
    icon: Icons.account_circle_outlined,
    label: '내정보',
  ),
];