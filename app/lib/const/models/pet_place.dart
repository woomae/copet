class PetPlaces{
  final int count;
  final List<PetPlace> row;
  PetPlaces({
    required this.count,
    required this.row
  });
  factory PetPlaces.fromJson(Map<String, dynamic> json) {
    return PetPlaces(
      count: json['count'],
      row: (json['rows'] as List<dynamic>)
        .map((item) => PetPlace.fromJson(item as Map<String, dynamic>))
        .toList(),
    );
  }

}


class PetPlace {
  final int id;
  final String title;
  final String detail;
  final String region;
  final String address;
  final double latitude;
  final double longitude;
  final String imgName;
  final DateTime createdAt;
  final DateTime updatedAt;

  PetPlace({
    required this.id,
    required this.title,
    required this.detail,
    required this.region,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.imgName,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PetPlace.fromJson(Map<String, dynamic> json) {
    return PetPlace(
      id: json['_id'],
      title: json['title'],
      detail: json['detail'],
      region: json['region'],
      address: json['address'],
      latitude: json['latitude'].toDouble(),
      longitude: json['longitude'].toDouble(),
      imgName: json['img_name'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}