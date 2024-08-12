import 'package:flutter/material.dart';
import 'package:pet/main/main_home.dart';
import 'package:pet/main/main_screen.dart';
import 'package:pet/pages/community/community_main.dart';
import 'package:pet/pages/map/map_page.dart';
import 'package:pet/pages/profile/profile_main.dart';
import 'package:pet/pages/search/search_main.dart';

class TabInfo {
  final String iconPath;
  final String selectedIconPath;
  final String label;
  final screen;

  const TabInfo({
    required this.iconPath,
    required this.selectedIconPath,
    required this.label,
    this.screen
  });
}

const TABS = [
  TabInfo(
    iconPath: 'asset/img/taps/mainicon.png',
    selectedIconPath: 'asset/img/taps/selectmain.png',
    label: '메인',
    screen : mainscreen()
  ),
  TabInfo(
    iconPath: 'asset/img/taps/chaticon.png',
    selectedIconPath: 'asset/img/taps/selectchat.png',
    label: '커뮤니티',
    screen: Community()
  ),
  TabInfo(
    iconPath: 'asset/img/taps/searchicon.png',
    selectedIconPath: 'asset/img/taps/selectsearch.png',
    label: '검색',
      screen: mainsearch()
  ),
  TabInfo(

    iconPath: 'asset/img/taps/mapicon.png',
    selectedIconPath: 'asset/img/taps/selectmap.png',
    label: '지도',
    screen: MapPage()

  ),
  TabInfo(
    iconPath: 'asset/img/taps/profileicon.png',
    selectedIconPath: 'asset/img/taps/selectprofile.png',
    label: '프로필',
    screen: ProfileMain()
  ),
];