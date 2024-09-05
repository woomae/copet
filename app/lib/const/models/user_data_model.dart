import 'package:pet/const/models/region_model.dart';

class PetKeyWords{
  final int id;
  final String keyword;
  final DateTime createdAt;
  final DateTime updatedAt;

  PetKeyWords({required this.id, required this.keyword, required this.createdAt, required this.updatedAt});

  factory PetKeyWords.fromJson(Map<String, dynamic> json) {
    return PetKeyWords(
      id: json['id'] ?? 0,
      keyword: json['keyword'] ?? '',
      createdAt: DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
    );
  }
}

class UserDataModel {
  final String? nickname;
  final String? pet_category;
  final Region? region;
  final String? intro;
  final String? photo;
  final List<String>? petkeyword;

  UserDataModel({
    required this.nickname,
    required this.pet_category,
    required this.region,
    required this.intro,
    required this.photo,
    required this.petkeyword,

  });
}
