import 'package:pet/const/models/users_model.dart';

class Friends {
  final int count;
  final List<UsersModel> users;

  Friends({
    required this.count,
    required this.users,
  });

  factory Friends.fromJson(Map<String, dynamic> json) {
    return Friends(
      count: json['result'][0]['count'] ?? 0,
      users: (json['result'][1] as List)
          .map((item) => UsersModel.fromJson(json: item as Map<String, dynamic>))
          .toList(),
    );
  }
}