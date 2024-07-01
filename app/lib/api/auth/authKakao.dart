import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthKakao {
  static Future<Response> authKakao() async {
    await dotenv.load(fileName: ".env");
    String? apiKey = dotenv.env['API_KEY'];
    final res = await Dio().get('$apiKey/auth/kakao');
    return res;
  }
}