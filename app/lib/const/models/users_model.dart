class UsersModel {
  final int id;
  final String nickname;
  final String email;
  final String pet_category;
  final String region;
  final String petimg;
  final String petkeyword;
  final String intro;
  final DateTime created_at;
  final DateTime updated_at;

  UsersModel({
    required this.id,
    required this.nickname,
    required this.email,
    required this.pet_category,
    required this.region,
    required this.petimg,
    required this.petkeyword,
    required this.intro,
    required this.created_at,
    required this.updated_at,

  });



UsersModel.fromJson({required Map<String, dynamic> json}):
  id = json['_id'] ?? 0,
  nickname = json['nickname'] ?? '',
  email = json['email'] ?? '',
  pet_category = json['category'] ?? '',
  region = json['region'] ?? '',
  petimg = json['petimg'] ?? '',
  petkeyword = json['petkeyword'] ?? '',
  intro = json['intro'] ?? '',
  created_at = DateTime.parse(json['created_at']) ?? DateTime.now(),
  updated_at = DateTime.parse(json['updated_at']) ?? DateTime.now();
}
//"updated_at": "2024-03-11T06:33:59.211Z"
//enum petCategory {} 로 특정 카테고리들을 추가해야함. 키워드도 마찬가지
