import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pet/const/models/articles.dart';
import '../dioBaseOptions.dart';

class GetArticles {
  static Future<Articles> getArticles({String? q, int? page, int? size, String? category, int? ownerId}) async {
    await dotenv.load(fileName: ".env");
    String? apiKey = dotenv.env['API_KEY'];

    Map<String, dynamic> queryParams = {};

    if (q != null) queryParams['q'] = q;
    if (page != null) queryParams['page'] = page;
    if (size != null) queryParams['size'] = size;
    if (category != null) queryParams['category'] = category;
    if (ownerId != null) queryParams['ownerId'] = ownerId;

    final res = await dio.get(
        '$apiKey/articles',
      queryParameters: queryParams
    );
    print(res);
    final Articles articles = Articles.fromJson(json: res.data['result']);
    return articles;
  }


  static Future<List<Article>> getOwnerArticles({required int userId}) async {
    await dotenv.load(fileName: ".env");
    String? apiKey = dotenv.env['API_KEY'];

    final res = await dio.get('$apiKey/articles?owner=$userId');
    final Articles articles = Articles.fromJson(json: res.data['result']);
    final List<Article> comments = articles.article.map(
            (e) => Article.fromJson(e as Map<String, dynamic>)).toList();
    print(res);
    return comments;
  }


  static Future<List<Article>> getLikeArticles({required int userId}) async {
    await dotenv.load(fileName: ".env");
    String? apiKey = dotenv.env['API_KEY'];


    final res = await dio.get('$apiKey/stars');
    final List<dynamic> resultList = res.data['result'];
    final List<Article> likedArticlesList = resultList.map((e)=> Stars.fromJson(e).articleId).toList();
    return likedArticlesList;
  }

  static Future<Article>? getSingleArticle({required String articleId}) async {
    await dotenv.load(fileName: ".env");
    String? apiKey = dotenv.env['API_KEY'];

    final res = await dio.get('$apiKey/articles/$articleId');
    final Article comments = Article.fromJson(res.data['result']);
    print(comments);
    return comments;
  }
}