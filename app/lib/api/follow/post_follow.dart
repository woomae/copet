import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PostFollow{
  static Future<Response> postFollow(int friendUserId) async {
    await dotenv.load(fileName: ".env");
    String? apiKey = dotenv.env['API_KEY'];

    final res = await Dio().post('$apiKey/friends', data: { 'friend_user_id' : friendUserId});
    return res;
  }
}
