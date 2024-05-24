import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pet/const/models/articles.dart';

class GetArticles {
  static Future<List<Comments>> getArticles() async {
    await dotenv.load(fileName: ".env");
    String? apiKey = dotenv.env['API_KEY'];

    final res = await Dio().get('$apiKey/articles?size=100');
    final Articles articles = Articles.fromJson(json: res.data['data']);
    final List<Comments> comments = articles.comments.map(
            (e) => Comments.fromJson(e as Map<String, dynamic>)).toList();
    
    return comments;
  }
}