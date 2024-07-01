import 'package:flutter/material.dart';

class Keyword {
  final String imagePath;
  final String name;

  Keyword({
    required this.imagePath,
    required this.name,
  });

}

final List<Keyword> keywords = [
  Keyword(imagePath: 'asset/img/keyword/energy.png', name: '에너자이저'),
  Keyword(imagePath: 'asset/img/keyword/sensitive.png', name: '예민'),
  Keyword(imagePath: 'asset/img/keyword/extroverted.png', name: '외향적'),
  Keyword(imagePath: 'asset/img/keyword/curiosity.png', name: '호기심쟁이'),
  Keyword(imagePath: 'asset/img/keyword/introverted.png', name: '내향적'),
  Keyword(imagePath: 'asset/img/keyword/loyalty.png', name: '충성스러워'),
  Keyword(imagePath: 'asset/img/keyword/sweet.png', name: '다정함'),
  Keyword(imagePath: 'asset/img/keyword/eat.png', name: '먹보'),
  Keyword(imagePath: 'asset/img/keyword/scared.png', name: '겁많은'),
  Keyword(imagePath: 'asset/img/keyword/activity.png', name: '활동적'),
  Keyword(imagePath: 'asset/img/keyword/calm.png', name: '차분한'),
  Keyword(imagePath: 'asset/img/keyword/cute.png', name: '애교쟁이'),
];