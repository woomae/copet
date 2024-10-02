import 'dart:convert';

// Merchandise 클래스
class Merchandise {
  final int id;
  final String name;
  final String detail;
  final String imgName;
  final DateTime createdAt;
  final DateTime updatedAt;

  Merchandise({
    required this.id,
    required this.name,
    required this.detail,
    required this.imgName,
    required this.createdAt,
    required this.updatedAt,
  });

  // JSON으로부터 Merchandise 객체를 생성
  factory Merchandise.fromJson(Map<String, dynamic> json) {
    return Merchandise(
      id: json['_id'],
      name: json['name'],
      detail: json['detail'],
      imgName: json['img_name'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}

// Merchandises 클래스
class Merchandises {
  final int count;
  final List<Merchandise> rows;

  Merchandises({
    required this.count,
    required this.rows,
  });

  // JSON으로부터 Merchandises 객체를 생성
  factory Merchandises.fromJson(Map<String, dynamic> json) {
    var list = json['rows'] as List;
    List<Merchandise> merchandiseList = list.map((i) => Merchandise.fromJson(i)).toList();

    return Merchandises(
      count: json['count'],
      rows: merchandiseList,
    );
  }

}