import 'package:image_picker/image_picker.dart';

class Articles {
  final int total;
  final List article;

  Articles(this.article, this.total);

  Articles.fromJson({required Map<String, dynamic> json}) :
      total = json['tottal'] ?? 0,
      article = json['articles'] ?? '';
}

class Article {
  final int iId;
  final int articleId;
  final String author;
  final String title;
  final String body;
  final String category;
  final List<XFile>? imgName;
  final int commentCount;
  final int scrapCount;
  final int complainCount;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Article(
      {required this.iId,
        required this.articleId,
        required this.author,
        required this.title,
        required this.body,
        required this.category,
        required this.imgName,
        required this.commentCount,
        required this.scrapCount,
        required this.complainCount,
        required this.createdAt,
        required this.updatedAt});

  Article.fromJson(Map<String, dynamic> json) :
    iId = json['_id'] ?? 0,
    articleId = json['article_id'] ?? 0,
    author = json['author'] ?? '',
    title = json['title'] ?? '',
    body = json['body'] ?? '',
    category = json['category'] ?? '',
    imgName = json['img_name'] ?? '',
    commentCount = json['comment_count'] ?? 0,
    scrapCount = json['scrap_count'] ?? 0,
    complainCount = json['complain_count'] ?? 0,
    createdAt = DateTime.parse(json['created_at']) ?? DateTime.now(),
    updatedAt = DateTime.parse(json['updated_at']) ?? DateTime.now();
  }
class Stars {
  final int iId;
  final int articleId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Stars(this.iId, this.articleId, this.createdAt, this.updatedAt);

  Stars.fromJson(Map<String, dynamic> json):
      iId = json['_id'] ?? 0,
      articleId = json['article_id'] ?? 0,
        createdAt = DateTime.parse(json['created_at']) ?? DateTime.now(),
        updatedAt = DateTime.parse(json['updated_at']) ?? DateTime.now();
}


