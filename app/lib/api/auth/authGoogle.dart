import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthGoogle{
  static Future<Response> authGoogle() async{
    await dotenv.load(fileName: ".env");
    String? apiKey = dotenv.env['API_KEY'];
    final res = await Dio().get('$apiKey/auth/google');
    return res;
  }
}