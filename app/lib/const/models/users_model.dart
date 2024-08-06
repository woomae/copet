import 'package:pet/const/models/region_model.dart';
import 'package:pet/const/models/user_data_model.dart';

class UsersModel {
  final int id;
  final String nickname;
  final String pet_category;
  final Region region;
  final List petimg;
  final List<String> petkeyword;
  final String intro;


  UsersModel({
    required this.id,
    required this.nickname,
    required this.pet_category,
    required this.region,
    required this.petimg,
    required this.petkeyword,
    required this.intro,

  });


UsersModel.fromJson({required Map<String, dynamic> json}):
  id = json['_id'] ?? 0,
  nickname = json['nickname'] ?? '',
  pet_category = json['pet_category'] ?? '',
  region = json['region'] == null ? Region(state: '', city: '', district: '') : Region.fromJson(json: json['region']),
  petimg = List.from(json['petimg'] ?? []),
  petkeyword = List<String>.from(json['petkeyword'] ?? []),
  intro = json['intro'] ?? '';
}