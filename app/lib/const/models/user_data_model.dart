class Region {
  final String? state;
  final String? city;
  final String? district;

  Region({required this.state, required this.city, required this.district});
}

class PetKeyWords{
  final int id;
  final String keyword;
  final DateTime createdAt;
  final DateTime updatedAt;

  PetKeyWords({required this.id, required this.keyword, required this.createdAt, required this.updatedAt});
}

class UserDataModel {
  final String? nickname;
  final String? pet_category;
  final Region? region;
  final String? intro;
  final String? photo;
  final List<PetKeyWords>? petkeyword;

  UserDataModel({
    required this.nickname,
    required this.pet_category,
    required this.region,
    required this.intro,
    required this.photo,
    required this.petkeyword,

  });
}
