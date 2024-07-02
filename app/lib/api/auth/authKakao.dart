import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../dioBaseOpstions.dart';

class AuthKakao {
  static Future<Response> authKakao() async {
    await dotenv.load(fileName: ".env");
    String? apiKey = dotenv.env['API_KEY'];
    final res = await dio.get('$apiKey/auth/kakao');
    return res;
  }
}