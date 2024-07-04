import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../dioBaseOpstions.dart';

class AuthGoogle{
  static Future<Response> authGoogle() async{
    await dotenv.load(fileName: ".env");
    String? apiKey = dotenv.env['API_KEY'];
    final res = await dio.get('$apiKey/auth/google');
    return res;
  }
}