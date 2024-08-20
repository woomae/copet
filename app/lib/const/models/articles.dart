import 'package:image_picker/image_picker.dart';

class Articles {
  final int total;
  final List<Article> article;

  Articles(this.article, this.total);

  Articles.fromJson({required Map<String, dynamic> json}) :
      total = json['total'] ?? 0,
      article = (json['articles'] as List<dynamic>?)
          ?.map((e) => Article.fromJson(e as Map<String, dynamic>))
          .toList() ?? [];
}

class Article {
  final int id;
  final String author;
  final String title;
  final String body;
  final String category;
  final List<Photo>? photos;
  final int commentCount;
  final int scrapCount;
  final int complainCount;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List? comments;
  final bool? isLike;

  Article(
      {required this.id,
        required this.author,
        required this.title,
        required this.body,
        required this.category,
        required this.photos,
        required this.commentCount,
        required this.scrapCount,
        required this.complainCount,
        required this.createdAt,
        required this.updatedAt,
        required this.comments,
        required this.isLike
      });

  Article.fromJson(Map<String, dynamic> json) :
        id = json['_id'] ?? 0,
        author = json['author'] ?? '',
        title = json['title'] ?? '',
        body = json['body'] ?? '',
        category = json['category'] ?? '',
        photos =  (json['photos'] as List).map((photo) => Photo.fromJson(photo)).toList(),
        commentCount = json['comment_count'] ?? 0,
        scrapCount = json['scrap_count'] ?? 0,
        complainCount = json['complain_count'] ?? 0,
        createdAt = json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
        updatedAt = json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
        comments = json['comments'] ?? [],
        isLike = json['islike'] ?? false;
  }

class Photo {
  final String imgPath;

  Photo({
    required this.imgPath,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      imgPath: json['img_path'],
    );
  }
}

class Stars {
  final Article articleId;

  Stars(this.articleId);

  Stars.fromJson(Map<String, dynamic> json):
      articleId = Article.fromJson(json['article_id']);
}


