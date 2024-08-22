class WalkMap {
  final int id;
  final String walkStartedAt;
  final int steps;
  final int durationSeconds;
  final DateTime createdAt;
  final String? photo;

  WalkMap({
    required this.id,
    required this.walkStartedAt,
    required this.steps,
    required this.durationSeconds,
    required this.createdAt,
    this.photo,
  });

  WalkMap.fromJson ({required Map<String, dynamic> json}) :
      id = json['_id'],
      walkStartedAt = json['walk_started_at'],
      steps = json['steps'],
      durationSeconds = json['duration_seconds'],
      createdAt = json['created_at'],
      photo = json['photo'];
}