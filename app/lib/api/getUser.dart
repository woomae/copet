import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../const/models/users_model.dart';

class GetUser{
  static Future<UsersModel> getUser(String id) async{
    await dotenv.load(fileName: ".env");
    String? apiKey = dotenv.env['API_KEY'];
    final res = await Dio().get('$apiKey/users/$id');
    print(res.data['data']);
    final user = UsersModel.fromJson(json: res.data['data']);
    return user;
  }
}