import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pet/const/models/articles.dart';

class GetArticles {
  static Future<List<Article>> getArticles() async {
    await dotenv.load(fileName: ".env");
    String? apiKey = dotenv.env['API_KEY'];

    final res = await Dio().get('$apiKey/articles?size=100');
    final Articles articles = Articles.fromJson(json: res.data['result']);
    final List<Article> comments = articles.article.map(
            (e) => Article.fromJson(e as Map<String, dynamic>)).toList();
    
    return comments;
  }


  static Future<List<Article>> getOwnerArticles({required String userId}) async {
    await dotenv.load(fileName: ".env");
    String? apiKey = dotenv.env['API_KEY'];

    final res = await Dio().get('$apiKey/articles?size=100&owner=$userId');
    final Articles articles = Articles.fromJson(json: res.data['result']);
    final List<Article> comments = articles.article.map(
            (e) => Article.fromJson(e as Map<String, dynamic>)).toList();

    return comments;
  }


  static Future<List<Article>> getLikeArticles({required int userId}) async {
    await dotenv.load(fileName: ".env");
    String? apiKey = dotenv.env['API_KEY'];

    List<Article> likedArticlesList = [];
    Article comment;

    final getStarRes = await Dio().get('$apiKey/stars',data: { 'clicked_user_id' : userId});
    final List<Stars> starResData = getStarRes.data['result'];
    print(starResData.runtimeType);
    if(starResData != []){
      final List<Stars> stars = starResData.map(
              (e) => Stars.fromJson(e as Map<String, dynamic>)).toList();

      stars.map((e) async {
        final res = await Dio().get('$apiKey/articles/$e');
        print('res : $res');
        comment = Article.fromJson(res.data['result']);
        likedArticlesList.add(comment);
      });
    }
    return likedArticlesList;
  }

  static Future<Article>? getSingleArticle({required String articleId}) async {
    await dotenv.load(fileName: ".env");
    String? apiKey = dotenv.env['API_KEY'];

    final res = await Dio().get('$apiKey/articles/$articleId');
    final Articles articles = Articles.fromJson(json: res.data['result']);
    final Article comments = Article.fromJson(articles as Map<String, dynamic>);

    return comments;
  }
}