import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DeleteArticle{
  static deleteArticle(String articleId) async{
    await dotenv.load(fileName: ".env");
    String? apiKey = dotenv.env['API_KEY'];

    final res = await Dio().delete('$apiKey/articles/$articleId');
    print(res);
  }
}