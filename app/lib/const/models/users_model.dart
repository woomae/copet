import 'package:pet/const/models/region_model.dart';
import 'package:pet/const/models/user_data_model.dart';

import 'articles.dart';

class UsersModel {
  final int id;
  final String nickname;
  final String petCategory;
  final Region region;
  final List<Photo> photo;
  final List<PetKeyWords> petKeywords;
  final String intro;

  UsersModel({
    required this.id,
    required this.nickname,
    required this.petCategory,
    required this.region,
    required this.photo,
    required this.petKeywords,
    required this.intro,
  });

  UsersModel.fromJson({required Map<String, dynamic> json})
      : id = json['_id'] ?? 0,
        nickname = json['nickname'] ?? '',
        petCategory = json['pet_category'] ?? '',
        region = json['region'] != null
            ? Region.fromJson(json: json['region'])
            : Region(state: '', city: '', district: ''),
        photo = (json['photo'] as List)
            .map((item) => Photo.fromJson(item as Map<String, dynamic>))
            .toList(),
        petKeywords = (json['petkeywords'] as List)
            .map((item) => PetKeyWords.fromJson(item))
            .toList(),
        intro = json['intro'] ?? '';
}