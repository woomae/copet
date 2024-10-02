import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../dioBaseOptions.dart';


Future<Response> deleteFollow(int friendUserId) async {
  await dotenv.load(fileName: ".env");
  String? apiKey = dotenv.env['API_KEY'];

  final res = await dio.delete('$apiKey/friends', data: { 'friend_user_id' : friendUserId});
  return res;
}
